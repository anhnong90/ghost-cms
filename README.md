<p align="right">🇬🇧 <em>English version below</em></p>

# 👻 Unser erstes Ghost CMS Projekt

> **Slogan:**  
> **_„Wir haben keine Angst vor Ghost – wir haben ihn selbst gehostet!!!“_**

---

## Was ist Ghost?

Ghost ist ein modernes, minimalistisches Content-Management-System (CMS), das speziell für Publisher, Startups und Entwickler:innen entwickelt wurde.  
Der Gründer **John O'Nolan** war früher Mitwirkender bei WordPress – bis er sich fragte:  
> „Was wäre, wenn es ein CMS gäbe, das sich auf Schreiben und Performance konzentriert – ohne Ballast?“

So entstand Ghost: schnell, offen, elegant.

---

## Systemübersicht

```plaintext
+-------------+       +------------------+       +------------------+
|  Nutzer:in  | <---> |   Browser (UI)   | <---> |   Ghost Frontend |
+-------------+       +------------------+       +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Ghost Backend    |
                                     | (Admin-Panel)    |
                                     +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Datenbank (SQLite|
                                     | oder PostgreSQL) |
                                     +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Server / Docker  |
                                     +------------------+

```

---
# Installations- und Deployment-Optionen

## 1️⃣ Ghost CLI Setup (ohne Docker)

### Empfohlen:

- Für Entwickler:innen mit VPS oder Root-Zugriff  
- Wenn du Ghost direkt ins Dateisystem installieren willst  
- Wenn du volle Kontrolle über Node.js und Systemdienste brauchst  

### Nicht empfohlen:

- Für Teams oder Präsentationen  
- Wenn du Docker verwendest  
- Wenn du Ghost portabel oder containerisiert betreiben willst  

### 🔧 Befehle:

```bash
sudo apt update
sudo apt install nodejs npm
sudo npm install ghost-cli -g
mkdir ghost-site && cd ghost-site
ghost install local
```
- Webseite: [http://localhost:2368](http://localhost:2368)  
- Admin: [http://localhost:2368/ghost](http://localhost:2368/ghost)

---

## 2️⃣ Lokale Installation mit Docker + SQLite

### Empfohlen:

- Für Präsentationen, Teamarbeit, schnelle Tests  
- Wenn du Ghost portabel und reproduzierbar starten willst
- Wenn du keine externe Datenbank brauchst  

### Nicht empfohlen:

- Wenn du PostgreSQL oder Cloud-Deployment brauchst  
- Wenn du keinen Docker installiert hast  

### 🔧 Setup-Befehle:

```bash
# Docker & Git installieren (falls nötig)
sudo apt update
sudo apt install git docker.io docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER && newgrp docker

# Projekt klonen
git clone https://github.com/<BENUTZERNAME>/cms-project.git
cd cms-project

# Datenbank-Verzeichnis vorbereiten
mkdir -p content/data
sudo chown -R 1000:1000 content

# Ghost starten
docker compose up -d
```
- Webseite: [http://localhost:2368](http://localhost:2368)  
- Admin: [http://localhost:2368/ghost](http://localhost:2368/ghost)


## 🌐 Zugriff im Netzwerk 

Falls du Ghost von einem anderen Gerät im WLAN öffnen willst:

```bash
ip addr show | grep inet
```
- Beispiel: http://192.168.254.142:2368
- Admin: http://192.168.254.142:2368/ghost

---

## 3️⃣ Hosting auf Render (Docker + PostgreSQL)

### Empfohlen:

- Für öffentlich erreichbare Seiten  
- Wenn du PostgreSQL verwenden willst  
- Wenn du CI/CD über GitHub nutzen willst  

---

### 🔧 Schritte:

1. Repository mit GitHub verbinden  
2. Neuen Web Service auf [Render](https://render.com) erstellen  
3. Als Deploy-Methode: **Docker Compose** wählen  
4. Environment-Variablen setzen:

```env
database__client=pg
database__connection__host=<HOST>
database__connection__user=<USER>
database__connection__password=<PASSWORT>
database__connection__database=<DATENBANKNAME>
database__connection__port=5432
url=https://<NAME>.onrender.com
```
Nach dem Build:
- Webseite: https://*name*.onrender.com
- Admin: https://*name*.onrender.com/ghost


## 📂 Projektstruktur

```
cms-project/
├── docker-compose.yml     # Startkonfiguration für Ghost
├── README.md              # Dokumentation
├── .gitignore             # Ausschluss von unnötigen Dateien
├── content/               # Ghost-Daten (lokal SQLite)
└── theme/                 # (optional) eigene Ghost-Theme
```
## ⚙️ docker-compose.yml (Beispiel, lokal SQLite)

```yaml
version: '3.1'

services:
  ghost:
    image: ghost:6-alpine
    ports:
      - "2368:2368"
    environment:
      url: http://localhost:2368
      database__client: sqlite3
      database__connection__filename: /var/lib/ghost/content/data/ghost-local.db
    volumes:
      - ./content:/var/lib/ghost/content
    restart: unless-stopped
```


## ▶️ Start / Stop / Logs

```bash
docker compose up -d         # Starten
docker compose logs -f       # Logs anzeigen
docker compose restart       # Neustart
docker compose down          # Stoppen (Daten bleiben erhalten)
```


## 🔧 Troubleshooting

- **Fehler:** `connection.filename fehlt`  
  → Pfad in `docker-compose.yml` prüfen

- **„permission denied“ bei Docker:**

```bash
sudo usermod -aG docker $USER
newgrp docker
```
- **💤 Render Free-Plan**

- Render schläft nach Inaktivität → kurz warten (30–60 Sekunden)

---

## 👥 Teamarbeit

- Weitere Personen können als **Staff User** eingeladen werden  
- Rollen: `Editor`, `Author`, `Contributor`  
- Inhalte exportieren/importieren:  
  → Admin → Settings → Labs → Export/Import

---

## 📌 Hinweise

- **Ghost Version:** `6.x (alpine)`  
- **Datenbank:** lokal SQLite, auf Render PostgreSQL  
- **Dokumentation:** [Ghost Docs](https://ghost.org/docs)

---

## 📧 Admin-Zugang (Demo)

- **E-Mail:** `cms@3akift.at`  
- **Passwort:** `anh^nataliia`

---

## 🔧 Troubleshooting

* **Fehler: `connection.filename` fehlt**
  → siehe `docker-compose.yml` oben, Pfad muss gesetzt sein.

* **„permission denied“ bei docker**

```bash
  sudo usermod -aG docker $USER
  newgrp docker
```

## 💤 Render Free-Plan

- Render schläft nach Inaktivität → kurz warten (30–60 Sekunden)

---

## 👥 Teamarbeit

- Weitere Personen können als **Staff User** eingeladen werden  
- Rollen: `Editor`, `Author`, `Contributor`  
- Inhalte exportieren/importieren:  
  → Admin → Settings → Labs → Export/Import

---

## 📌 Hinweise

- **Ghost Version:** `6.x (alpine)`  
- **Datenbank:** lokal SQLite, auf Render PostgreSQL  
- **Dokumentation:** [Ghost Docs](https://ghost.org/docs)

---

## 📧 Admin-Zugang (Demo)

- **E-Mail:** `cms@3akift.at`  
- **Passwort:** `anh^nataliia`

---
## Offizielle Dokumentation

Ghost verfügt über eine sehr gute offizielle Dokumentation, die den gesamten Prozess der Installation, Einrichtung und Nutzung ausführlich beschreibt.  
Die Dokumentation ist hier verfügbar: [Ghost Docs](https://docs.ghost.org/introduction)

Wir haben sie während der Installation und Konfiguration von Ghost in Docker genutzt, da sie folgende Vorteile bietet:
- Schritt-für-Schritt-Anleitungen für verschiedene Umgebungen (lokal, Docker, Cloud),
- Erklärung der grundlegenden Konzepte (Posts, Pages, Tags, Navigation, Themes),
- Leitfäden zur Administration, SEO und Erweiterungen,
- Detaillierte Code-Beispiele und API-Beschreibungen.

Dank dieser Dokumentation war die Arbeit mit Ghost wesentlich einfacher und übersichtlicher.

---
---
<br/><br/><br/>



# 👻 Our First Ghost CMS Project

> **Slogan:**  
> **_“We’re not afraid of Ghost — we hosted it ourselves!”_**

---

## What is Ghost?

Ghost is a modern, minimalist content management system (CMS) designed specifically for publishers, startups, and developers.  
Its founder **John O'Nolan** was previously a contributor to WordPress — until he asked:  
> “What if there were a CMS focused purely on writing and performance — without the bloat?”  

Thus, Ghost was born: fast, open, and elegant.

---

## System Overview

```plaintext
+-------------+       +------------------+       +------------------+
|   User      | <---> |   Browser (UI)   | <---> |   Ghost Frontend |
+-------------+       +------------------+       +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Ghost Backend    |
                                     | (Admin Panel)    |
                                     +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Database (SQLite |
                                     | or PostgreSQL)   |
                                     +------------------+
                                               |
                                               v
                                     +------------------+
                                     | Server / Docker  |
                                     +------------------+

```
---

# Installation & Deployment Options

## 1️⃣ Ghost CLI Setup (without Docker)
### **Recommended for:**
- Developers with VPS or root access
- Direct installation into the file system
- Full control over Node.js and system services

### **Not recommended for:**
- Team collaboration or presentations
- Docker-based workflows
- Portable or containerized setups

🔧 **Commands:**
```bash
sudo apt update
sudo apt install nodejs npm
sudo npm install ghost-cli -g
mkdir ghost-site && cd ghost-site
ghost install local
```
- Website: http://localhost:2368
- Admin: http://localhost:2368/ghost

## 2️⃣ Local Installation with Docker + SQLite

### **Recommended for:**

- Presentations, teamwork, quick testing
- Portable and reproducible Ghost setups
- No need for external databases

### **Not recommended for:**

- PostgreSQL or cloud deployments
- Systems without Docker installed

### 🔧 Setup Commands:
```bash
# Install Docker & Git (if needed)
sudo apt update
sudo apt install git docker.io docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER && newgrp docker

# Clone the project
git clone https://github.com/<USERNAME>/cms-project.git
cd cms-project

# Prepare database directory
mkdir -p content/data
sudo chown -R 1000:1000 content

# Start Ghost
docker compose up -d
```
- Website: http://localhost:2368
- Admin: http://localhost:2368/ghost

## 🌐 Access via Local Network

If you want to access Ghost from another device on the same Wi-Fi:

```bash
ip addr show | grep inet
```
- Example: http://192.168.254.142:2368 
- Admin: http://192.168.254.142:2368/ghost


## 3️⃣ Hosting on Render (Docker + PostgreSQL)
### Recommended for:
- Publicly accessible websites
- PostgreSQL database usage
- CI/CD integration via GitHub

### 🔧 Steps:
- Connect your GitHub repository
- Create a new Web Service on Render
- Choose Docker Compose as the deployment method
- Add the following environment variables:
```env
database__client=pg
database__connection__host=<HOST>
database__connection__user=<USER>
database__connection__password=<PASSWORD>
database__connection__database=<DB_NAME>
database__connection__port=5432
url=https://<NAME>.onrender.com
```
After build completion:
- Website: https://**name**.onrender.com
- Admin: https://**name**.onrender.com/ghost

## 📂 Project Structure
```plaintext
cms-project/
├── docker-compose.yml     # Ghost startup configuration
├── README.md              # Documentation
├── .gitignore             # Excludes unnecessary files
├── content/               # Ghost data (local SQLite)
└── theme/                 # (optional) custom Ghost theme
```
## ⚙️ docker-compose.yml (Example for local SQLite)
```yaml
version: '3.1'

services:
  ghost:
    image: ghost:6-alpine
    ports:
      - "2368:2368"
    environment:
      url: http://localhost:2368
      database__client: sqlite3
      database__connection__filename: /var/lib/ghost/content/data/ghost-local.db
    volumes:
      - ./content:/var/lib/ghost/content
    restart: unless-stopped
```

## ▶️ Start / Stop / Logs
```bash
docker compose up -d         # Start
docker compose logs -f       # View logs
docker compose restart       # Restart
docker compose down          # Stop (data remains)
```

## 🔧 Troubleshooting
**Error:** connection.filename missing → Check the path in docker-compose.yml

**Permission denied when using Docker:**

```bash
sudo usermod -aG docker $USER
newgrp docker
```
## 💤 Render Free Plan
Render may sleep after inactivity → wait 30–60 seconds

## 👥 Team Collaboration
- Invite additional users as Staff Users

- Roles: Editor, Author, Contributor

- Export/import content: → Admin → Settings → Labs → Export/Import

## 📌 Notes
- Ghost Version: 6.x (alpine)

- Database: SQLite locally, PostgreSQL on Render

- Documentation: Ghost Docs

## 📧 Admin Access (Demo)
- Email: cms@3akift.at

- Password: anh^nataliia

# Official Documentation
Ghost offers excellent official documentation covering installation, setup, and usage.  
Available at: [Ghost Docs](https://ghost.org/docs)

We used it extensively during our Docker-based setup because it provides:

- Step-by-step guides for various environments (local, Docker, cloud)  
- Clear explanations of core concepts (posts, pages, tags, navigation, themes)  
- Admin, SEO, and extension guides  
- Detailed code examples and API references  

Thanks to this documentation, working with Ghost was much easier and more organized.