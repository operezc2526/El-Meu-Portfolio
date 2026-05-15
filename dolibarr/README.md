# 🏥 Clínica Veterinària — CRM/ERP amb Dolibarr

> Implementació d'un sistema de gestió empresarial per a una clínica veterinària utilitzant Dolibarr com a solució CRM/ERP open source.

---

## 📋 Descripció del projecte

La clínica veterinària necessitava digitalitzar la seva gestió diària i obrir noves fonts d'ingressos a través de la venda de productes per a mascotes. Per cobrir aquesta necessitat s'ha implementat Dolibarr, una solució CRM/ERP open source que permet gestionar clients, animals, productes i facturació des d'un mateix sistema.

L'objectiu real d'aprenentatge no és només configurar un programari, sinó entendre com funcionen els sistemes ERP/CRM en el món professional i com s'adapten a les necessitats específiques d'un negoci.

---

## 🛠️ Tecnologies utilitzades i per a què s'han utilitzat

| Tecnologia | Ús en el projecte |
|---|---|
| **Dolibarr** | Sistema CRM/ERP principal per a la gestió de la clínica |
| **MySQL** | Base de dades subjacent on Dolibarr emmagatzema tota la informació |
| **Servidor web** | Allotjament de la instància de Dolibarr accessible des del navegador |
| **PHP** | Llenguatge base de Dolibarr, comprensió del seu funcionament intern |

---

## ⚙️ Funcionalitats implementades

### Instal·lació i configuració
- Instal·lació de Dolibarr en un servidor web local
- Configuració inicial del sistema: nom de l'empresa, moneda, idioma i mòduls actius
- Configuració de la base de dades MySQL subjacent
- Creació de l'usuari administrador i configuració de permisos

### Gestió de clients i animals
- Alta de clients (propietaris de les mascotes) amb dades de contacte
- Registre d'animals associats a cada client amb espècie, raça i historial
- Gestió de cites i visites veterinàries
- Historial de serveis per a cada animal

### Venda de productes per a mascotes
- Creació del catàleg de productes per a mascotes (pinso, accessoris, medicaments)
- Gestió d'estoc i preus de venda
- Creació de pressupostos i factures per a clients
- Registre de comandes i vendes

---

## 👨‍💻 Contribució personal

- He instal·lat i configurat Dolibarr des de zero en un entorn de servidor local
- He activat i configurat els mòduls necessaris per a la gestió de la clínica
- He creat l'estructura de clients, animals i productes adaptada a les necessitats de la clínica
- He configurat el sistema de facturació i vendes per a la venda de productes
- He adaptat la configuració general del sistema per reflectir la identitat de la clínica

---

## 🔧 Problemes trobats i solucions aplicades

**Problema 1 — Configuració inicial del servidor**
Dolibarr requereix un servidor web amb PHP i MySQL configurat correctament. La instal·lació inicial va presentar problemes de permisos sobre les carpetes del sistema.
**Solució:** Revisar i ajustar els permisos de les carpetes `documents/` i `conf/` del servidor per permetre l'escriptura per part del servei web.

**Problema 2 — Mòduls no visibles després d'activar-los**
Alguns mòduls activats no apareixien al menú principal de l'aplicació.
**Solució:** Buidar la caché del navegador i reiniciar la sessió d'administrador per forçar la recàrrega de la configuració dels mòduls.

**Problema 3 — Relació entre clients i animals**
Per defecte Dolibarr no té un mòdul específic per a animals — gestiona contactes de forma genèrica.
**Solució:** Utilitzar el mòdul de tercers per als propietaris i el mòdul de productes/serveis per registrar els animals com a entitats associades als clients.

---

## 📚 Què he après durant el desenvolupament

- Com instal·lar i configurar un sistema **ERP/CRM real** en un entorn de servidor
- Com funcionen els sistemes de gestió empresarial i quins processos de negoci digitalitzen
- La importància del **programari lliure (open source)** com a alternativa viable en entorns professionals
- Com adaptar una solució genèrica a les necessitats específiques d'un negoci concret
- Com gestionar un sistema amb **múltiples mòduls interdependents** i configurar-los coherentment
- La relació entre un ERP i la seva **base de dades subjacent** (MySQL en aquest cas)

---

## ▶️ Instruccions per accedir al sistema

**Requisits:**
- Servidor web amb PHP 7.4 o superior
- MySQL 5.7 o superior
- Dolibarr 16.x o superior

**Accés:**
1. Instal·la Dolibarr seguint la [documentació oficial](https://wiki.dolibarr.org/index.php/Installation_-_Upgrade)
2. Configura la base de dades MySQL
3. Accedeix via navegador a `http://localhost/dolibarr`
4. Inicia sessió amb les credencials d'administrador

---

*Curs 2025-2026 · Desenvolupament d'Aplicacions Multiplataforma · Centre d'Estudis Politècnics*
