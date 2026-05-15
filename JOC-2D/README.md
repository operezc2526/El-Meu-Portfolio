# 🎮 Dan Dan Dish — Pixel Duel Game

> Joc de duels pixel art desenvolupat amb Java Swing i MySQL com a projecte intermodular del cicle de Desenvolupament d'Aplicacions Multiplataforma.

---

## 📋 Descripció del projecte

Dan Dan Dish és un joc de duels per a un jugador contra la màquina, inspirat en la mecànica de pedra-paper-tisores però amb una temàtica de pistoles pixel art estil retro. El jugador introdueix el seu nom i s'enfronta a la màquina en una partida al millor de 3 rondes. En cada ronda tria una de les tres accions disponibles:

- 🔫 **Disparar** — guanya a Recarregar
- 🔄 **Recarregar** — guanya a Escut
- 🛡️ **Escut** — guanya a Disparar

La màquina tria aleatòriament. Guanya qui primer aconsegueix 3 rondes. En acabar, el resultat es guarda a la base de dades MySQL i es mostra el ranking dels 10 millors jugadors.

El projecte inclou també una **identitat corporativa completa** dissenyada amb Figma i una **Landing Page Mobile First** en HTML/CSS/JS.

---

## 🛠️ Tecnologies utilitzades i per a què s'han utilitzat

| Tecnologia | Ús en el projecte |
|---|---|
| **Java** | Lògica del joc, arquitectura MVC, gestió d'esdeveniments |
| **Java Swing** | Interfície gràfica: finestres, botons, etiquetes i layouts |
| **MySQL** | Emmagatzematge de resultats de partides i consulta de ranking |
| **JDBC** | Connexió entre Java i MySQL amb PreparedStatement |
| **JUnit** | Tests unitaris per verificar les regles del joc |
| **JavaDoc** | Documentació professional de totes les classes |
| **Git / GitHub** | Control de versions, branques i historial de canvis |
| **Figma** | Manual d'identitat corporativa i prototipat de la Landing Page |
| **HTML / CSS / JS** | Landing Page Mobile First amb estètica pixel art |

---

## ⚙️ Funcionalitats principals

- **Menú inicial** — el jugador introdueix el seu nom abans de començar
- **Lògica de joc** — tres accions amb regles de victòria/derrota/empat
- **Màquina aleatòria** — la màquina tria aleatòriament entre les tres accions
- **Marcador en temps real** — el HUD mostra les rondes guanyades per cada banda
- **Detecció del final** — la partida acaba automàticament quan algú arriba a 3 rondes
- **Persistència de dades** — els resultats es guarden a MySQL en acabar la partida
- **Ranking Top 10** — es mostra al final de cada partida amb els millors resultats
- **Tests unitaris** — verificació automàtica de les regles del joc amb JUnit
- **Documentació JavaDoc** — documentació completa de totes les classes

---

## 👨‍💻 Contribució personal

El projecte és completament individual. He estat responsable de totes les decisions tècniques i de disseny:

- He dissenyat l'**arquitectura MVC** del projecte amb sis classes principals: `Main`, `MenuNom`, `JocFrame`, `JocController`, `Partida` i `DBManager`
- He implementat tota la **lògica del joc** des de zero, incloent les regles d'enfrontament i els comptadors de rondes
- He creat el **model relacional** de la base de dades i les consultes SQL per guardar i recuperar resultats
- He documentat totes les classes amb **JavaDoc** i he generat la web de documentació
- He escrit els **tests unitaris** amb JUnit per verificar les tres regles del joc i els comptadors
- He gestionat el **repositori GitHub** amb commits progressius, branques i etiqueta v1.0
- He dissenyat la **identitat corporativa** completa del joc amb Figma
- He desenvolupat la **Landing Page Mobile First** seguint el manual d'identitat

---

## 🔧 Problemes trobats i solucions aplicades

**Problema 1 — Finestra del menú es mostrava en blanc**
En prémer el botó Jugar la finestra es tancava però el joc no s'obria. El problema era que el bucle `while` del `Main` bloquejava el EDT (Event Dispatch Thread) de Swing abans que la finestra pogués pintar-se.
**Solució:** Reestructurar el flux d'inici separant la creació de la vista de l'inici del joc. `MenuNom` crida directament `Main.iniciarJoc(nom)` un cop validat el nom, eliminant el bucle de l'espera.

**Problema 2 — Les imatges no es carregaven al executar el JAR**
Les imatges es carregaven correctament des d'IntelliJ però fallaven en executar el JAR. El problema era que les rutes relatives no funcionen dins d'un JAR.
**Solució:** Moure les imatges a la carpeta `resources` marcada com a Resources Root i usar `getClass().getResource("/images/...")` per carregar-les independentment de l'entorn.

**Problema 3 — El JAR no trobava el driver MySQL**
En executar el JAR des de la terminal sortia un error de driver no trobat malgrat funcionar correctament a IntelliJ.
**Solució:** Configurar l'artifact a `Project Structure` d'IntelliJ per incloure el `mysql-connector-j-9.7.0.jar` dins del JAR final.

**Problema 4 — Comanda `java` no reconeguda a Windows**
En intentar executar el JAR des de la terminal de Windows sortia l'error "java no es reconeix com a comanda".
**Solució:** Afegir la ruta del JDK (`C:\Users\oriol\.jdks\ms-25.0.0\bin`) a les variables d'entorn `PATH` de Windows.

---

## 📚 Què he après durant el desenvolupament

**Programació i arquitectura**
- Com estructurar un projecte Java seguint el patró **MVC** per separar responsabilitats
- Com funciona el **EDT de Swing** i per què totes les operacions gràfiques han d'executar-se en aquest fil
- Com connectar Java amb MySQL usant **JDBC** i `PreparedStatement` per evitar injeccions SQL
- Com escriure **tests unitaris** amb JUnit i per què són fonamentals per garantir la qualitat del codi
- Com aplicar **refactoring** per millorar la llegibilitat del codi sense canviar el comportament

**Disseny i comunicació**
- Com crear una **identitat visual coherent** aplicant principis professionals de color, tipografia i espaiat
- Com dissenyar amb enfocament **Mobile First** i per què és l'estàndard actual en disseny web
- Com aplicar **tècniques de persuasió** en el disseny d'interfícies per guiar el comportament de l'usuari

**Metodologia professional**
- La importància del **control de versions** amb Git per mantenir un historial clar i poder revertir canvis
- Com documentar codi professionalment amb **JavaDoc** per facilitar el manteniment i la col·laboració
- Com diagnosticar i resoldre **errors tècnics** de forma autònoma cercant informació i aplicant solucions

---

## 🗂️ Estructura del projecte
piedra_papel_tijeras/
├── src/
│   ├── main/Main.java
│   ├── model/Partida.java
│   ├── view/MenuNom.java
│   ├── view/JocFrame.java
│   ├── controller/JocController.java
│   ├── database/DBManager.java
│   └── utils/Constants.java
├── resources/
│   └── db/dandandish.sql
├── lib/
│   └── mysql-connector-j-9.7.0.jar
├── test/
│   └── PartidaTest.java
└── README.md
---

## ▶️ Instruccions per executar

**Requisits:**
- Java 17 o superior
- MySQL Server en execució
- Base de dades `dandandish` creada (veure `resources/db/dandandish.sql`)

**Passos:**
1. Clona el repositori: `git clone https://github.com/operezc2526/piedra_papel_tijeras`
2. Executa el SQL a MySQL Workbench: `resources/db/dandandish.sql`
3. Configura la contrasenya a `utils/Constants.java`
4. Executa `main.Main` des d'IntelliJ o amb `java -jar piedra_papel_tijeras.jar`

---

## 📫 Contacte

- **GitHub:** [@operezc2526](https://github.com/operezc2526)

---

*Curs 2024-2025 · Desenvolupament d'Aplicacions Multiplataforma · Centre d'Estudis Politècnics*
