-- 1. Mirar si hay mas de un entrenador
DROP TRIGGER IF EXISTS entrenador_unic;
DELIMITER $$
CREATE TRIGGER entrenador_unic
BEFORE INSERT ON entrenar_equips
FOR EACH ROW
BEGIN
    DECLARE te_entrenador INT;

    SELECT COUNT(*) INTO te_entrenador
    FROM entrenar_equips
    WHERE equips_id = NEW.equips_id
      AND entrenadors_id IS NOT NULL;

    IF te_entrenador > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede incluir mas de un entrenador por equipo';
    END IF;
END$$
DELIMITER ;

-- 2. EN INSERT
DROP TRIGGER IF EXISTS capacidad_espectadors_incompatible_insert;
DELIMITER $$
CREATE TRIGGER capacidad_espectadors_incompatible_insert
BEFORE INSERT ON estadis
FOR EACH ROW
BEGIN
    IF NEW.num_espectadors < 5000 THEN
        SET NEW.num_espectadors = 5000;
    END IF;
    
    IF NEW.num_espectadors > 100000 THEN
        SET NEW.num_espectadors = 100000;
    END IF;
END $$
DELIMITER ;
-- 2. EN UPDATE
DROP TRIGGER IF EXISTS capacidad_espectadors_incompatible_update;
DELIMITER $$
CREATE TRIGGER capacidad_espectadors_incompatible_update
BEFORE UPDATE ON estadis
FOR EACH ROW
BEGIN
    IF NEW.num_espectadors < 5000 THEN
        SET NEW.num_espectadors = 5000;
    END IF;
    
    IF NEW.num_espectadors > 100000 THEN
        SET NEW.num_espectadors = 100000;
    END IF;
END $$
DELIMITER ;

-- 3.
DROP TRIGGER IF EXISTS impedir_fichar_entrenador_alta
DELIMITER $$
CREATE TRIGGER impedir_fichar_entrenador_alta 
BEFORE INSERT ON entrenar_equips 
FOR EACH ROW
BEGIN
	DECLARE te_equip int;
    SELECT COUNT(*) INTO te_equip
    FROM entrenar_equips
    WHERE entrenadors_id = NEW.entrenadors_id
      AND data_baixa IS NULL;
	
	IF te_contracte_vigent > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aquest entrenador ja te un contracte vigent.';
	END IF;
END $$

DELIMITER ;

-- 4. 
DROP TRIGGER IF EXISTS normalitzar_persones_insert;
DELIMITER $$
CREATE TRIGGER normalitzar_persones_insert
BEFORE INSERT ON persones
FOR EACH ROW
BEGIN
    SET NEW.nom     = CONCAT(UPPER(LEFT(NEW.nom, 1)),     LOWER(SUBSTRING(NEW.nom, 2)));
    SET NEW.cognoms = CONCAT(UPPER(LEFT(NEW.cognoms, 1)), LOWER(SUBSTRING(NEW.cognoms, 2)));
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS normalitzar_persones_update;
DELIMITER $$
CREATE TRIGGER normalitzar_persones_update
BEFORE UPDATE ON persones
FOR EACH ROW
BEGIN
    SET NEW.nom = CONCAT(UPPER(LEFT(NEW.nom, 1)), LOWER(SUBSTRING(NEW.nom, 2)));
    SET NEW.cognoms = CONCAT(UPPER(LEFT(NEW.cognoms, 1)), LOWER(SUBSTRING(NEW.cognoms, 2)));
END$$
DELIMITER ;

-- 5.
DROP TRIGGER IF EXISTS control_max_jugadors;

DELIMITER $$

CREATE TRIGGER control_max_jugadors
BEFORE INSERT ON jugadors_equips
FOR EACH ROW
BEGIN
    DECLARE total_jugadors INT;
    
    SELECT COUNT(*) INTO total_jugadors
    FROM jugadors_equips
    WHERE equips_id = NEW.equips_id
      AND data_baixa IS NULL;
    
    IF total_jugadors >= 25 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LEquip ja te 25 jugadors actius.';
    END IF;
END$$

DELIMITER ;

-- 6.
DROP TRIGGER IF EXISTS control_partit_duplicat;

DELIMITER $$

CREATE TRIGGER control_partit_duplicat
BEFORE INSERT ON partits
FOR EACH ROW
BEGIN
    DECLARE total_partits INT;
    
    SELECT COUNT(*) INTO total_partits
    FROM partits
    WHERE jornades_id = NEW.jornades_id
      AND (
          (equips_id_local = NEW.equips_id_local AND equips_id_visitant = NEW.equips_id_visitant)
          OR
          (equips_id_local = NEW.equips_id_visitant AND equips_id_visitant = NEW.equips_id_local)
      );
    
    IF total_partits > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aquests dos equips ja tenen un partit programat en aquesta jornada.';
    END IF;
END$$

DELIMITER ;

-- 7.
DROP TRIGGER IF EXISTS control_equip_ja_te_partit;

DELIMITER $$

CREATE TRIGGER control_equip_ja_te_partit
BEFORE INSERT ON partits
FOR EACH ROW
BEGIN
    DECLARE total_partits INT;
    
    SELECT COUNT(*) INTO total_partits
    FROM partits
    WHERE jornades_id = NEW.jornades_id
      AND (
          equips_id_local    = NEW.equips_id_local    OR
          equips_id_visitant = NEW.equips_id_local    OR
          equips_id_local    = NEW.equips_id_visitant OR
          equips_id_visitant = NEW.equips_id_visitant
      );
    
    IF total_partits > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un dels equips ja té un partit programat en aquesta jornada.';
    END IF;
END$$

DELIMITER ;

-- 8.
CREATE TABLE IF NOT EXISTS canvis_sou_jugadors (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    persones_id   INT          NOT NULL,
    sou_antic     FLOAT        NOT NULL,
    sou_nou       FLOAT        NOT NULL,
    data_canvi    DATE         NOT NULL
);
DROP TRIGGER IF EXISTS registre_canvi_sou;
DELIMITER $$
CREATE TRIGGER registre_canvi_sou
AFTER UPDATE ON persones
FOR EACH ROW
BEGIN
    IF NEW.sou > OLD.sou THEN
        INSERT INTO canvis_sou_jugadors (persones_id, sou_antic, sou_nou, data_canvi)
        VALUES (OLD.id, OLD.sou, NEW.sou, CURDATE());
    END IF;
END$$
DELIMITER ;

-- 9.
CREATE TABLE IF NOT EXISTS log_equips_modificats (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    nom_equip           VARCHAR(45)  NOT NULL,
    president_antic     VARCHAR(45)  NOT NULL,
    president_nou       VARCHAR(45)  NOT NULL,
    data_canvi          DATE         NOT NULL
);
DROP TRIGGER IF EXISTS registre_canvi_president;
DELIMITER $$
CREATE TRIGGER registre_canvi_president
AFTER UPDATE ON equips
FOR EACH ROW
BEGIN
    IF NEW.nom_president <> OLD.nom_president THEN
        INSERT INTO log_equips_modificats (nom_equip, president_antic, president_nou, data_canvi)
        VALUES (OLD.nom, OLD.nom_president, NEW.nom_president, CURDATE());
    END IF;
END$$
DELIMITER ;

-- 10.
CREATE TABLE IF NOT EXISTS log_errors_jornades (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    lligues_id  INT          NOT NULL,
    jornada     INT          NOT NULL,
    descripcio  VARCHAR(200) NOT NULL,
    data_error  DATE         NOT NULL
);
DROP TRIGGER IF EXISTS control_jornada_duplicada;
DELIMITER $$
CREATE TRIGGER control_jornada_duplicada
BEFORE INSERT ON jornades
FOR EACH ROW
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM jornades
    WHERE lligues_id = NEW.lligues_id
      AND jornada = NEW.jornada;
    
    IF total > 0 THEN
        INSERT INTO log_errors_jornades (lligues_id, jornada, descripcio, data_error)
        VALUES (
            NEW.lligues_id,
            NEW.jornada,
            CONCAT('Intent de duplicar la jornada ', NEW.jornada, ' a la lliga ', NEW.lligues_id),
            CURDATE()
        );
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ja existeix aquesta jornada per aquesta lliga.';
    END IF;
END$$
DELIMITER ;

-- 11.
CREATE TABLE IF NOT EXISTS jugadors_eliminats (
    id                INT          NOT NULL,
    nom               VARCHAR(45)  NOT NULL,
    cognoms           VARCHAR(45)  NOT NULL,
    data_naixement    DATE,
    nivell_motivacio  INT,
    sou               FLOAT,
    tipus_persona     VARCHAR(45),
    data_esborrat     DATETIME     NOT NULL
);
DROP TRIGGER IF EXISTS registre_jugador_eliminat;
DELIMITER $$
CREATE TRIGGER registre_jugador_eliminat
BEFORE DELETE ON persones
FOR EACH ROW
BEGIN
    IF OLD.tipus_persona = 'jugador' THEN
        INSERT INTO jugadors_eliminats (
            id, nom, cognoms, data_naixement,
            nivell_motivacio, sou, tipus_persona, data_esborrat
        )
        VALUES (
            OLD.id, OLD.nom, OLD.cognoms, OLD.data_naixement,
            OLD.nivell_motivacio, OLD.sou, OLD.tipus_persona, NOW()
        );
    END IF;
END$$
DELIMITER ;
-- Funciona en tots els casos? 
-- No, quan s'elimina desde jugadors, quan es trunca la taula o quan s'elimina de forma massiva no funciona,
-- Perque el trigger nomes elimina persones que siguin jugadors i el truncate es salta tots els triggers

-- 12.
CREATE TABLE IF NOT EXISTS entrenadors_eliminats (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    persones_id     INT             NOT NULL,
    nom             VARCHAR(45)     NOT NULL,
    cognoms         VARCHAR(45)     NOT NULL,
    nom_equip       VARCHAR(45)     NOT NULL,
    data_esborrat   DATETIME        NOT NULL
);
DROP PROCEDURE IF EXISTS eliminar_entrenador;
DELIMITER $$
CREATE PROCEDURE eliminar_entrenador(IN p_id INT)
BEGIN
    -- Variables
    DECLARE v_nom VARCHAR(45);
    DECLARE v_cognoms VARCHAR(45);
    DECLARE v_nom_equip VARCHAR(45) DEFAULT 'Sense equip vigent';
    DECLARE v_equip_id INT DEFAULT NULL;
    DECLARE error_ocorregut BOOLEAN DEFAULT FALSE;
    
    -- Capturar qualsevol error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error_ocorregut = TRUE;
    
    START TRANSACTION;
    -- 1. Obtenir dades de lEntrenador
    SELECT p.nom, p.cognoms
    INTO v_nom, v_cognoms
    FROM persones p
    WHERE p.id = p_id AND p.tipus_persona = 'entrenador';
    
    -- 2. Comprovar si te equip actiu
    SELECT ee.equips_id INTO v_equip_id
    FROM entrenar_equips ee
    WHERE ee.entrenadors_id = p_id
      AND ee.data_baixa IS NULL
    LIMIT 1;
    
    -- 3. Si te equip actiu, obtenir el nom i tancar la relacio
    IF v_equip_id IS NOT NULL THEN
        SELECT e.nom INTO v_nom_equip
        FROM equips e
        WHERE e.id = v_equip_id;
        
        UPDATE entrenar_equips
        SET data_baixa = CURDATE()
        WHERE entrenadors_id = p_id
          AND data_baixa IS NULL;
    END IF;
    
    -- 4. Registrar a entrenadors_eliminats
    INSERT INTO entrenadors_eliminats (persones_id, nom, cognoms, nom_equip, data_esborrat)
    VALUES (p_id, v_nom, v_cognoms, v_nom_equip, NOW());
    
    -- 5. Eliminar de entrenadors
    DELETE FROM entrenadors WHERE persones_id = p_id;
    
    -- 6. Eliminar de persones
    DELETE FROM persones WHERE id = p_id;
    
    -- Comprovar si hi ha hagut errors
    IF error_ocorregut THEN
        ROLLBACK;
        SELECT 'Error: no sHan aplicat els canvis.' AS resultat;
    ELSE
        COMMIT;
        SELECT CONCAT('Entrenador ', v_nom, ' ', v_cognoms, ' eliminat correctament.') AS resultat;
    END IF;

END$$
DELIMITER ;

-- 13.
DROP PROCEDURE IF EXISTS estadistiques_jugador;
DELIMITER $$
CREATE PROCEDURE estadistiques_jugador(IN p_id INT)
BEGIN
    DECLARE v_nom VARCHAR(45);
    DECLARE v_cognoms VARCHAR(45);
    DECLARE v_partits INT;
    DECLARE v_gols INT;

    -- Obtenir nom del jugador
    SELECT nom, cognoms INTO v_nom, v_cognoms
    FROM persones
    WHERE id = p_id AND tipus_persona = 'jugador';

    -- Comptar gols
    SELECT COUNT(*) INTO v_gols
    FROM partits_gols
    WHERE jugadors_id = p_id;

    -- Comptar partits jugats
    SELECT COUNT(DISTINCT partits_id) INTO v_partits
    FROM partits_gols
    WHERE jugadors_id = p_id;

    SELECT
        v_nom AS nom,
        v_cognoms AS cognoms,
        v_gols AS total_gols,
        v_partits AS partits_jugats;
END$$
DELIMITER ;

-- 14.
DROP PROCEDURE IF EXISTS reassignar_entrenador;
DELIMITER $$
CREATE PROCEDURE reassignar_entrenador(IN p_equip_id INT, IN p_entrenador_id INT)
BEGIN
    DECLARE error_ocorregut BOOLEAN DEFAULT FALSE;
    DECLARE v_te_contracte  INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error_ocorregut = TRUE;
    START TRANSACTION;
    -- 1. Comprovar que l'entrenador existeix
    SELECT COUNT(*) INTO v_te_contracte
    FROM entrenadors
    WHERE persones_id = p_entrenador_id;
    IF v_te_contracte = 0 THEN
        SET error_ocorregut = TRUE;
    ELSE
        -- 2. Tancar contracte vigent si en té
        UPDATE entrenar_equips
        SET data_baixa = CURDATE()
        WHERE entrenadors_id = p_entrenador_id
          AND data_baixa IS NULL;

        -- 3. Crear nova relació amb l'equip indicat
        INSERT INTO entrenar_equips (entrenadors_id, equips_id, data_alta, data_baixa)
        VALUES (p_entrenador_id, p_equip_id, CURDATE(), NULL);
    END IF;
    -- 4. Comprovar errors i fer COMMIT o ROLLBACK
    IF error_ocorregut THEN
        ROLLBACK;
        SELECT 'Error: no sHan aplicat els canvis.' AS resultat;
    ELSE
        COMMIT;
        SELECT CONCAT('Entrenador reassignat correctament a lEquip ', p_equip_id) AS resultat;
    END IF;
END$$
DELIMITER ;

-- 15. 
CREATE TABLE golejadors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoria VARCHAR(20), -- Ex: '+10 gols'
  total_jugadors INT,
  lliga VARCHAR(100),
  data_calcul TIMESTAMP
);
DROP PROCEDURE IF EXISTS estadistica_gols_lliga;

DELIMITER $$

CREATE PROCEDURE estadistica_gols_lliga(IN p_nom_lliga VARCHAR(100))
BEGIN
    DECLARE error_ocorregut BOOLEAN DEFAULT FALSE;
    DECLARE v_missatge      TEXT;
    DECLARE v_total_10      INT;
    DECLARE v_total_20      INT;
    DECLARE v_total_30      INT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET error_ocorregut = TRUE;
        GET DIAGNOSTICS CONDITION 1 v_missatge = MESSAGE_TEXT;
    END;

    START TRANSACTION;

    SELECT COUNT(*) INTO v_total_10
    FROM (
        SELECT g.jugadors_id, COUNT(*) AS total_gols
        FROM gols g
        INNER JOIN partits p  ON p.id = g.partits_id
        INNER JOIN jornades j ON j.id = p.jornades_id
        INNER JOIN lligues  l ON l.id = j.lligues_id
        WHERE l.nom = p_nom_lliga
        GROUP BY g.jugadors_id
        HAVING total_gols > 10
    ) AS sub;

    SELECT COUNT(*) INTO v_total_20
    FROM (
        SELECT g.jugadors_id, COUNT(*) AS total_gols
        FROM gols g
        INNER JOIN partits p  ON p.id = g.partits_id
        INNER JOIN jornades j ON j.id = p.jornades_id
        INNER JOIN lligues  l ON l.id = j.lligues_id
        WHERE l.nom = p_nom_lliga
        GROUP BY g.jugadors_id
        HAVING total_gols > 20
    ) AS sub;

    SELECT COUNT(*) INTO v_total_30
    FROM (
        SELECT g.jugadors_id, COUNT(*) AS total_gols
        FROM gols g
        INNER JOIN partits p  ON p.id = g.partits_id
        INNER JOIN jornades j ON j.id = p.jornades_id
        INNER JOIN lligues  l ON l.id = j.lligues_id
        WHERE l.nom = p_nom_lliga
        GROUP BY g.jugadors_id
        HAVING total_gols > 30
    ) AS sub;

    INSERT INTO golejadors (categoria, total_jugadors, lliga, data_calcul)
    VALUES
        ('+10 gols', v_total_10, p_nom_lliga, NOW()),
        ('+20 gols', v_total_20, p_nom_lliga, NOW()),
        ('+30 gols', v_total_30, p_nom_lliga, NOW());

    IF error_ocorregut THEN
        ROLLBACK;
        SELECT CONCAT('Error: ', v_missatge) AS resultat;
    ELSE
        COMMIT;
        SELECT categoria, total_jugadors, lliga, data_calcul
        FROM golejadors
        WHERE lliga = p_nom_lliga
        ORDER BY categoria;
    END IF;

END$$

DELIMITER ;

CALL estadistica_gols_lliga('La Liga EA Sports');