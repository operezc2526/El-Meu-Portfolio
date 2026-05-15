# 🎨 Dan Dan Dish — Identitat Corporativa i Landing Page

> Manual d'identitat corporativa complet i disseny de Landing Page Mobile First per al joc Dan Dan Dish, desenvolupats amb Figma.

---

## 📋 Descripció del projecte

Aquest apartat recull el treball de disseny visual del joc Dan Dan Dish. S'ha creat una identitat corporativa completa que defineix com ha de veure's i sentir-se la marca del joc, i s'ha aplicat aquesta identitat al disseny d'una Landing Page Mobile First pensada per persuadir els usuaris a jugar.

L'objectiu real d'aprenentatge és comprendre com es construeix una identitat visual professional, com es prenen decisions de disseny justificades i com s'apliquen principis d'accessibilitat, tipografia, color i persuasió en un producte digital real.

---

## 🛠️ Tecnologies utilitzades i per a què s'han utilitzat

| Tecnologia | Ús en el projecte |
|---|---|
| **Figma** | Disseny del manual d'identitat corporativa i prototipat de la Landing Page |
| **Google Fonts** | Tipografies Press Start 2P i VT323 per a l'estètica pixel art |
| **WCAG** | Estàndard d'accessibilitat per validar els contrastos de color |

---

## 📖 Manual d'Identitat Corporativa

El manual d'identitat és el document que defineix com s'ha d'usar la marca Dan Dan Dish de forma coherent en tots els suports. Inclou les seccions següents:

### 🖼️ Moodboard
Recull d'inspiració visual amb referències de jocs pixel art retro, estètica arcade dels 80-90, duels de western pixelats i ambient chiptune. Paraules clau que guien el procés creatiu:
**DUEL · RETRO · PIXEL · NOSTALGIA · COMPETICIÓ**

### 🎯 Missió, Visió i Valors
- **Missió:** Reviure l'emoció dels duels clàssics en format digital retro, portant la tensió del "DRAW!" a qualsevol pantalla
- **Visió:** Ser el joc de duels més nostàlgic i addictiu de la web, referent en el gènere indie retro
- **Valors:** Nostalgia · Competitivitat · Simplicitat · Diversió

### 🔵 Logo
Logo pixel art amb dues pistoles enfrontades i el títol "DAN DAN DISH" en tipografia Press Start 2P. El manual defineix:
- Variants de color (fons fosc i fons de color sòlid)
- Usos incorrectes (no rotar, no deformar, no canviar colors, no sense contrast)
- Espai de respecte mínim de 16px al voltant del logo

### 🎨 Paleta de Colors

| Color | Hex | Ús | Contrast WCAG |
|---|---|---|---|
| Principal | `#1a1a2e` | Fons de pantalla, targetes, seccions | — |
| Secundari | `#e94560` | CTAs, títols, alertes, acció SHOOT | 7.2:1 AAA |
| Destacat | `#f5a623` | Puntuació, destacats, acció RELOAD | 5.8:1 AA |
| Alerta | `#0f3460` | Fons de targetes, acció SHIELD | 3.1:1 |
| Text | `#eaeaea` | Tot el text de cos, icones, etiquetes | 12.4:1 AAA |

**Prohibit:** No usar degradats, transparències ni ombres suaus. El joc és tot píxels sòlids.

### ✍️ Tipografia

**Font primària — Press Start 2P** (Google Fonts)
Ús: Títols H1/H2, botons CTA, etiquetes d'accions, tots els textos de joc principals.
- H1: 32px · Títol principal
- H2: 24px · Subtítol
- H3: 16px · Etiqueta d'acció
- Body: 12px · Text cos (mínim 10px)

**Font secundària — VT323** (Google Fonts)
Ús: Textos descriptius, subtítols llargs, instruccions, taglines i cos de manual.
- Mínim 16px per llegibilitat

**Regles tipogràfiques:**
- Mai usar fonts serif o sans-serif genèriques
- Sempre en majúscules per a títols amb Press Start 2P
- Interlineat mínim x1.5

### 📐 Maquetació — Sistema de Layout

**Mobile First** — disseny base a 390×844px (iPhone 14)

| Paràmetre | Valor |
|---|---|
| Grid base | 8px |
| Gutter | 8px |
| Padding pàgina | 20px |
| Amplada màxima | 390px |

**Escala d'espaiat:**
XS=8px · SM=16px · MD=24px · LG=32px · XL=40px · XXL=48px

**Regles:** Botons mínim 44px d'alçada · Icones mínim 48×48px · Cap element fora dels 390px

### 💡 Tècniques de Persuasió
- **Urgència** — compte enrere per forçar decisions ràpides
- **Prova social** — "1,247 jugadors actius ara mateix" i taula de ranking
- **Escassetat** — vides limitades que incrementen el valor de cada decisió
- **CTA clara** — botó principal sempre visible amb jerarquia visual clara

---

## 🌐 Disseny de la Landing Page

La Landing Page ha estat dissenyada a Figma seguint estrictament les pautes del manual d'identitat. Està pensada per persuadir els usuaris a accedir al joc.

### Estructura (Mobile First — 390px)

| Secció | Alçada | Contingut |
|---|---|---|
| **Hero** | 200px | Logo provisional + CTA "PLAY NOW" + jugadors actius |
| **How to Play** | 180px | 3 targetes d'acció + regles del joc + compte enrere |
| **High Scores** | 200px | Top 5 jugadors + CTA secundari |
| **Footer** | 48px | Credits · Info |

### Decisions de disseny
- Fons `#1a1a2e` amb efecte scanlines subtil per simular una pantalla CRT retro
- Separadors entre seccions amb quadrats alternant `#e94560` i `#f5a623`
- Tots els elements amb cantonades de 0px (sharp corners) — estètica pixel art pura
- Ombres offset `3px 3px 0px #000` sense blur per mantenir l'estètica

---

## 👨‍💻 Contribució personal

- He definit les **paraules clau** i la direcció creativa del projecte partint de zero
- He triat i justificat la **paleta de colors** aplicant criteris de contrast WCAG
- He seleccionat les **tipografies** adequades per a l'estètica pixel art
- He dissenyat el **sistema de layout** basat en una quadrícula de 8px
- He documentat els **bons i mals usos** de cada element de disseny
- He aplicat **tècniques de persuasió** al disseny de la Landing Page
- He creat el prototipat complet de la Landing Page a **Figma** seguint el manual

---

## 🔧 Problemes trobats i solucions aplicades

**Problema 1 — La IA de Figma no respectava les mides exactes**
En generar el disseny amb la IA integrada de Figma, els elements no respectaven les mides del manual (altures de seccions, padding, mides de botons).
**Solució:** Redactar prompts molt detallats i precisos especificant cada mida en píxels, cada codi de color hexadecimal i cada regla de maquetació de forma explícita i exhaustiva.

**Problema 2 — Seccions de la Landing Page es superposaven**
Les seccions generades per la IA es solapaven entre elles, fent el disseny inutilitzable.
**Solució:** Especificar altures mínimes per a cada secció, prohibir explícitament el solapament i indicar que l'alçada total del frame havia d'expandir-se per contenir tot el contingut.

**Problema 3 — Icones d'acció amb aspecte de sistema operatiu**
Les icones de les tres accions (SHOOT, RELOAD, SHIELD) es mostraven com a icones genèriques del sistema en lloc d'elements pixel art.
**Solució:** Especificar que les icones havien de ser formes simples creades amb rectangles de Figma, prohibint explícitament l'ús d'emojis i biblioteques d'icones externes.

---

## 📚 Què he après durant el desenvolupament

- Com construir una **identitat visual coherent** des de zero aplicant principis de disseny professional
- La importància del **sistema de colors** i com els contrastos WCAG garanteixen l'accessibilitat
- Com funciona el **disseny Mobile First** i per què és l'estàndard actual en disseny web
- Com aplicar **tècniques de persuasió** (urgència, prova social, escassetat) en el disseny d'interfícies
- Com redactar **prompts efectius** per a IAs de disseny, sent molt específic i detallat
- La diferència entre un disseny genèric i un disseny amb **identitat pròpia i reconeixible**
- Com documentar decisions de disseny de forma professional en un **manual d'identitat**

---

## 🔗 Enllaços

- **Figma:** [Veure disseny a Figma](https://figma.com)
- **Manual d'identitat:** disponible a la carpeta `manual-identitat/`

---

*Curs 2025-2026 · Desenvolupament d'Aplicacions Multiplataforma · Centre d'Estudis Politècnics*
