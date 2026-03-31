# Linux Setup
Gemacht für Ubuntu Setup. Geschrieben und getestet auf ZorinOS 18 CORE.
All in one essential Befehl:
```bash
sudo apt update && sudo apt upgrade
sudo apt install curl wget gpg vlc unzip
```

Ich empfehle, wenn man Sachen für Linux sucht, auf [FMHY](https://fmhy.net/linux-macos) zu schauen.

# Necessities
## Zen Browser:
```bash
flatpak install flathub app.zen_browser.zen
```
WICHTIG FÜR MULTI-MONITOR-SETUP: in about:config zen.window-sync enabled auf "false" setzen

## Chromium
Benötigt für Flutter Development und alternative falls Signavio das Arbeiten verhindert,
```bash
sudo apt install chromium-browser
```

## AppImageLauncher
Der [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher) erlaubt einem AppImages einfach alls Apps zu integrieren
```bash
cd ~/Downloads
sudo apt install ./appimagelauncher-*.deb
```

## JetBrains Toolbox
Die .tar.gz Datei von der offiziellen [JetBrains Seite](https://www.jetbrains.com/toolbox-app/) herunterladen.

```bash
cd ~/Downloads
tar -xzf jetbrains-toolbox-*.tar.gz
```
```bash
cd jetbrains-toolbox-*/
chmod +x jetbrains-toolbox
./jetbrains-toolbox
```

Jetzt sämtlichen Programme installieren die benötigt sind (e.g. PyCharm, IntelliJ IDEA, DataGrip, Android Studio)

## Flutter
Die tar.xz Datei von der [Flutter Webseite](https://docs.flutter.dev/install/manual) herunterladen.
```bash
sudo apt update
sudo apt install curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev
```
```bash
mkdir ~/development
```
Im development Ordner:
```bash
tar xf ~/Downloads/flutter_linux_*.tar.xz
```
Danach im Terminal eingeben und schauen welche Probleme auftreten.
```bash
flutter doctor
```
Für "[!] Android toolchain - develop for Android devices (Android SDK version 36.1.0)" macht man folgendes:

- Android Studio starten
- More Action -> SDK Manager
- SDK Tools
- Suche nach "Android SDK Command-line Tools"
- Hacken setzen und auf "apply" gehen

## Docker
Aufsetzen durch folgen des Tutorials auf der [Docker Webseite](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
Oder durch pasten der Commands hier:
```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```
Hiermit installierst du die neuste Version:
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Testen auf Funktionalität durch laufen des **hello-world** images
```bash
sudo docker run hello-world
```
Damit man nicht immer sudo eingeben muss:
```bash
sudo usermod -aG docker $USER
```

### MSSQL-Docker
Herunterladen des Dockers von [Werner Gitschthaler](https://gitlab.com/wgitscht/mssql-docker)
```bash
mkdir mssql-docker
cd ~/Downloads
mv ~/Downloads/mssql-docker-main.zip ~/mssql-docker/
```
In mssql-docker:
```bash
unzip mssql-docker-main.zip
cd mssql-docker-main
docker compose up
```
Ich empfehle das Password in der docker-composer.yml auf etwas leichter merkbares umzuändern.

## DSAI Install Party
Hier kann man der Install Party aus dem Skript [Franz Reichels](https://gitlab.com/reif1337/refr_dsai_script) folgen.

### GraphViz
```bash
sudo apt install -y graphviz
```

### MiniConda installieren
```bash
cd ~/Downloads
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

```bash
bash Miniconda3-latest-Linux-x86_64.sh
```
- Press 'Enter' to continue
- Type 'yes'
- Install location: leave empty for (/home/username/miniconda3)

### Activate Conda
```bash
source ~/.bashrc
```

### Conda Environment "dsai" ohne NVIDIA
```bash
# 1. Environment erstellen
conda create -n dsai python=3.11.13 -y
conda activate dsai

# 2. Standard-Pakete installieren
conda install -c conda-forge jupyter scikit-learn seaborn numpy pandas scikit-image python-graphviz -y
pip install --upgrade pip
pip install tensorflow

# 3. Test
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

### Conda Environemt "dsai" mit NVIDIA
```bash
# 1. Environment erstellen
conda create -n dsai-gpu python=3.11.13 -y
conda activate dsai-gpu

# 2. CUDA & cuDNN direkt in das Environment installieren
# (Dadurch verhinderst du Konflikte mit dem restlichen System)
conda install -c conda-forge cudatoolkit=11.8 cudnn=8.9.2 -y

# 3. Standard-Pakete installieren
conda install -c conda-forge jupyter scikit-learn seaborn numpy pandas scikit-image python-graphviz -y

# 4. TensorFlow mit GPU-Unterstützung (ab v2.10+ erkennt TF die GPU automatisch via Pip)
pip install --upgrade pip
pip install tensorflow

# 5. Test
python -c "import tensorflow as tf; print('GPUs gefunden:', tf.config.list_physical_devices('GPU'))"
```

### Jupyter Kerne registrieren
```bash
conda install ipykernel -y
python -m ipykernel install --user --name=dsai --display-name "Python (dsai)"
```

## Affinity für SYP-Zweig
Da von der Professorin Kern das Programm "Affinity von Canva" verlangt wird holt man sich den AppImage Installer von [GitHub](https://github.com/ryzendew/Linux-Affinity-Installer):
```bash
cd ~/Downloads
chmod +x Affinity-3-x86_64.AppImage
./Affinity-3-x86_64.AppImage
```

## Markdown Reader/Editor
```bash
flatpak install flathub org.gnome.gitlab.somas.Apostrophe
```

# Private/Fun

## Steam
Steam am besten von der [offiziellen Webseite](https://store.steampowered.com/about/) holen
```bash
cd ~/Downloads
sudo apt install steam_latest.deb
```

## Discord
Für unterwegs empfehle ich die Vesktop. Für die Hauptmaschine empfehle ich das offizielle .deb Package gepatched mit Vencord.

### Vesktop Version
```bash
flatpak install flathub dev.vencord.Vesktop
```

### Offizielle .deb Version
Offiziell Version holen von der [Discord Webseite](https://discord.com/)

Mein Patch-Skript, jedes Mal laufen wenn der Discord Installer eine neue Version herunterlädt:

- Erstelle eine Datei mit dem Namen den der Patch-Befehl haben soll (in meinem Fall "discordfix")
```bash
#!/bin/bash

# Directory where your Discord deb gets downloaded
DOWNLOAD_DIR="$HOME/Downloads"

# Find the newest Discord .deb file
DEB_FILE=$(ls -t "$DOWNLOAD_DIR"/discord-0.0.*.deb 2>/dev/null | head -n 1)

if [ -z "$DEB_FILE" ]; then
    echo "❌ No Discord .deb file found in $DOWNLOAD_DIR"
    exit 1
fi

echo "📦 Installing Discord from: $DEB_FILE"
sudo apt install "$DEB_FILE" || { echo "❌ Failed to install Discord"; exit 1; }

echo "🎀 Installing Vencord..."
sh -c "$(curl -sS https://vencord.dev/install.sh)" || { echo "❌ Vencord install failed"; exit 1; }

echo "🧹 Removing .deb file..."
rm "$DEB_FILE" || { echo "⚠️ Could not delete $DEB_FILE"; }

echo "✅ Discord installed, patched, and cleaned up!"
```

- Ausführbar machen
```bash
chmod +x discordfix
```

- In deinen PATH verschieben
```bash
sudo mv discordfix /usr/local/bin/
```

## Minecraft
Beste Methode Minecraft zu spielen ist durch PrismLauncher
```bash
flatpak install flathub org.prismlauncher.PrismLauncher
```

## Krita
Einfach das AppImage von der [offiziellen Seite](https://krita.org/en/download/) holen und per AppImageLauncher ausführen.

## Spotify
Einfach die Befehle unten ausführen. Installiert das offizielle .deb Paket
```bash
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/spotify.gpg

echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client
```

Hier mein Patch-Skript für Spicetify, gleiche Schritte wie bei Discord.
```bash
#!/bin/bash
Spicetify reinstall/update..." curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh echo "Done!"
```

Danach sollte man Spicetify laufen:
```bash
spicetify
```

Falls Fehler kommen, einfach fixen
```bash
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
```

Danach:
```bash
spicetify backup apply
```

Bei der Frage ob der Marketplace mitinstalliert werden soll, "Ja" sagen.

## QBitTorrent
```bash
sudo apt update
sudo apt install qbittorrent
```

## EBooks
Ich empfehle Calibre als EBook-Editor für Klassenlektüren und Bücher im Allgemeinen. Als EBook-Reader empfehle ich [Google Books](https://play.google.com/books)
```bash
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
```