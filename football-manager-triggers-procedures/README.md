# ⚽ Football Manager — Automatització i Integritat de la Base de Dades

> Implementació de procedures i triggers MySQL per automatitzar tasques i garantir la integritat de les dades en una base de dades de gestió esportiva.

---

## 📋 Descripció del projecte

La base de dades del Football Manager gestiona equips, jugadors, fitxatges, transferències i lligues. Per garantir que les dades es mantenen coherents i per automatitzar tasques repetitives, s'han implementat procedures i triggers MySQL que actuen de forma automàtica davant de determinades operacions sobre la base de dades.

L'objectiu real d'aprenentatge és comprendre com la lògica de negoci es pot implementar directament a la base de dades, sense dependre de l'aplicació que la consumeix, garantint la integritat de les dades independentment de quin sistema les modifiqui.

---

## 🛠️ Tecnologies utilitzades i per a què s'han utilitzat

| Tecnologia | Ús en el projecte |
|---|---|
| **MySQL** | Base de dades relacional principal del Football Manager |
| **Stored Procedures** | Automatització de tasques repetitives com fitxatges i transferències |
| **Triggers** | Garantia d'integritat de dades davant d'insercions, actualitzacions i esborrats |
| **MySQL Workbench** | Entorn de desenvolupament per crear i provar procedures i triggers |

---

## ⚙️ Procedures implementats

Els stored procedures encapsulen lògica de negoci complexa que s'executaria repetidament, permetent cridar-la amb una sola instrucció.

### Exemple — Procedure de fitxatge
```sql
DELIMITER //
CREATE PROCEDURE realitzar_fitxatge(
    IN p_jugador_id INT,
    IN p_equip_origen_id INT,
    IN p_equip_desti_id INT,
    IN p_preu DECIMAL(10,2)
)
BEGIN
    -- Eliminar jugador de l'equip origen
    UPDATE jugadors
    SET equip_id = p_equip_desti_id
    WHERE id = p_jugador_id;

    -- Registrar la transferència
    INSERT INTO transferencies (jugador_id, equip_origen_id, equip_desti_id, preu, data)
    VALUES (p_jugador_id, p_equip_origen_id, p_equip_desti_id, p_preu, NOW());

    -- Actualitzar el pressupost dels equips
    UPDATE equips SET pressupost = pressupost + p_preu WHERE id = p_equip_origen_id;
    UPDATE equips SET pressupost = pressupost - p_preu WHERE id = p_equip_desti_id;
END //
DELIMITER ;

-- Crida al procedure
CALL realitzar_fitxatge(10, 1, 3, 5000000.00);
```

---

## ⚙️ Triggers implementats

Els triggers s'executen automàticament quan es produeix una operació (INSERT, UPDATE, DELETE) sobre una taula, sense que l'aplicació hagi de fer res explícitament.

### Exemple — Trigger per limitar jugadors per equip
```sql
DELIMITER //
CREATE TRIGGER before_insert_jugador
BEFORE INSERT ON jugadors
FOR EACH ROW
BEGIN
    DECLARE num_jugadors INT;

    SELECT COUNT(*) INTO num_jugadors
    FROM jugadors
    WHERE equip_id = NEW.equip_id;

    IF num_jugadors >= 25 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: l\'equip ja té el màxim de 25 jugadors permesos';
    END IF;
END //
DELIMITER ;
```

### Exemple — Trigger per registrar canvis de dorsal
```sql
DELIMITER //
CREATE TRIGGER after_update_dorsal
AFTER UPDATE ON jugadors
FOR EACH ROW
BEGIN
    IF OLD.dorsal != NEW.dorsal THEN
        INSERT INTO historial_dorsals (jugador_id, dorsal_anterior, dorsal_nou, data_canvi)
        VALUES (OLD.id, OLD.dorsal, NEW.dorsal, NOW());
    END IF;
END //
DELIMITER ;
```

---

## 👨‍💻 Contribució personal

- He identificat quines tasques repetitives es podien encapsular en **procedures** per simplificar les operacions des de l'aplicació
- He implementat procedures per a les operacions més complexes: fitxatges, transferències i actualització de pressupostos
- He identificat els punts crítics de la base de dades on calia garantir la **integritat de les dades** amb triggers
- He implementat triggers `BEFORE INSERT` per validar regles de negoci abans que les dades s'emmagatzemin
- He implementat triggers `AFTER UPDATE` per registrar l'historial de canvis importants
- He provat tots els procedures i triggers amb casos reals i casos límit per verificar el seu correcte funcionament

---

## 🔧 Problemes trobats i solucions aplicades

**Problema 1 — Error de sintaxi amb DELIMITER**
En crear procedures amb múltiples instruccions SQL, MySQL confonia el `;` intern amb el final del procedure.
**Solució:** Usar `DELIMITER //` abans de la definició del procedure i `DELIMITER ;` al final per indicar a MySQL quin caràcter delimita el final del procedure complet.

**Problema 2 — Trigger en bucle infinit**
Un trigger `AFTER UPDATE` que feia un `UPDATE` sobre la mateixa taula provocava una crida recursiva infinita.
**Solució:** Reestructurar la lògica per evitar modificar la mateixa taula dins del trigger, usant una taula d'historial separada per registrar els canvis.

**Problema 3 — Procedure no veia els canvis fets per un trigger**
Quan un procedure cridava un `INSERT` i un trigger associat modificava dades, el procedure no reflectia els canvis inmediatament.
**Solució:** Entendre l'ordre d'execució de MySQL: els triggers `BEFORE` s'executen abans de l'operació i els `AFTER` després. Ajustar la lògica del procedure en conseqüència.

---

## 📚 Què he après durant el desenvolupament

- La diferència entre **procedures** i **triggers** i quan és adequat usar cadascun
- Com encapsular **lògica de negoci complexa** directament a la base de dades per garantir que s'aplica independentment de l'aplicació
- Com usar `SIGNAL SQLSTATE` per llançar **errors personalitzats** des d'un trigger quan es viola una regla de negoci
- La importància de l'**ordre d'execució** dels triggers (BEFORE vs AFTER) i com afecta al resultat
- Com evitar **recursivitat no desitjada** en triggers que modifiquen la mateixa taula
- Com provar procedures i triggers amb **casos límit** per verificar que funcionen correctament en tots els escenaris

---

## ▶️ Instruccions per executar

**Requisits:**
- MySQL Server 8.0 o superior
- MySQL Workbench

**Passos:**
1. Importa la base de dades del Football Manager
2. Executa `oriol_perez_triggers_procedures_fm.sql` per crear tots els procedures
4. Prova els procedures amb: `CALL nom_procedure(parametres);`

---

*Curs 2025-2026 · Desenvolupament d'Aplicacions Multiplataforma · Centre d'Estudis Politècnics*
