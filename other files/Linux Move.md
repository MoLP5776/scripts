# Linux Move
All in one essential command:
```bash
sudo apt update && sudo apt upgrade
sudo apt install curl wget gpg vlc unzip
```

# Necessities
## Zen Browser:
```bash
flatpak install flathub app.zen_browser.zen
```
IMPORTANT FOR MULTI-MONITOR SETUP: in about:config set "zen.window-sync enabled" to "false"

## AppImageLauncher
The [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher) allows you to easily integrate AppImages
```bash
cd ~/Downloads
sudo apt install ./appimagelauncher-*.deb
```

## Spotify
Just follow the commands, installs the .deb package of Spotify
```bash
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/spotify.gpg

echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client
```

Here my patch-script for Spicetify.
```bash
#!/bin/bash
Spicetify reinstall/update..." curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh echo "Done!"
```

After this, one should run spicetify:
```bash
spicetify
```

If errors occur, simply fix them
```bash
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
```

After that:
```bash
spicetify backup apply
```

If asked if the marketplace should be installed as well, answer "yes".

## Steam
Get Steam from the [official Website](https://store.steampowered.com/about/)
```bash
cd ~/Downloads
sudo apt install steam_latest.deb
```

## Discord
Try official .deb version first. If it doesn't work, use flathub.

Patch with vencord command.

## QBitTorrent
```bash
sudo apt update
sudo apt install qbittorrent
```

## Manga-TUI
Download the 64-bit Linux archive adn extract it
```bash
# Download the archive
wget https://github.com/josueBarretogit/manga-tui/releases/download/v0.10.0/manga-tui-0.10.0-x86_64-unknown-linux-gnu.tar.gz

# Extract the archive
tar -xvf manga-tui-0.10.0-x86_64-unknown-linux-gnu.tar.gz
```

Install to your system path
```bash
sudo mv manga-tui /usr/local/bin/
```

Clean up
```bash
rm manga-tui-0.10.0-x86_64-unknown-linux-gnu.tar.gz
```

You can now run `manga-tui` to download manga
## Krita
Get from the [official website](https://krita.org/en/download/) and run with AppImageLauncher. 

## Minecraft
Best way to play Minecraft
```bash
flatpak install flathub org.prismlauncher.PrismLauncher
```


## JetBrains Toolbox
Download .tar.gz file from the [JetBrains site](https://www.jetbrains.com/toolbox-app/).

```bash
cd ~/Downloads
tar -xzf jetbrains-toolbox-*.tar.gz
```
```bash
cd jetbrains-toolbox-*/
chmod +x jetbrains-toolbox
./jetbrains-toolbox
```

## EBooks
I recommend Calibre for editing book metadata. As Ebup reader, I recommend [Google Books](https://play.google.com/books)
```bash
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
```

## Docker
Setup through following the guide on the [official website](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
Or through pasting of this command:
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
Install newest version with this:
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Testing through running the **hello-world** images
```bash
sudo docker run hello-world
```
Adding user to admin group to no longer write sudo:
```bash
sudo usermod -aG docker $USER
```

## Affinity for Linux
Download from this [GitHub](https://github.com/ryzendew/Linux-Affinity-Installer) repository:
```bash
cd ~/Downloads
chmod +x Affinity-3-x86_64.AppImage
./Affinity-3-x86_64.AppImage
```

## OBS
```bash
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio
```

## EasyTAG
```bash
flatpak install flathub org.gnome.EasyTAG
```

## Kdenlive
```bash
flatpak install flathub org.kde.kdenlive
```

## Resource Managers
Either Resources or Mission Center
```bash
flatpak install flathub net.nokyan.Resources
```

```bash
flatpak install flathub io.missioncenter.MissionCenter
```

## Sitra
```bash
flatpak install flathub io.github.sitraorg.sitra
```

# Management
## Warehouse
```bash
flatpak install flathub io.github.flattool.Warehouse
```

## FlatSeal
```bash
flatpak install flathub com.github.tchx84.Flatseal
```

# Emulators

## MelonDS
```bash
flatpak install flathub net.kuribo64.melonDS
```

## AzaharPlus
Get from the [GitHub repository](https://github.com/AzaharPlus/AzaharPlus) and install with AppImageLauncher.


# bash aliases
```bash
alias manga='cd ~/.local/share/manga-tui/mangaDownloads'
alias mangadex='manga-tui'
alias weebcentral='manga-tui -p weebcentral'

alias sims-up='rclone sync "/home/$USER/.local/share/Steam/steamapps/compatdata/1222670/pfx/drive_c/users/steamuser/Documents/Electronic Arts/The Sims 4/saves" dropbox:SimsSaves -P'
alias sims-down='rclone sync dropbox:SimsSaves "/home/$USER/.local/share/Steam/steamapps/compatdata/1222670/pfx/drive_c/users/steamuser/Documents/Electronic Arts/The Sims 4/saves" -P'
alias school-up='rclone sync "/home/$USER/Documents/School" dropbox:School -P'
alias school-down='rclone sync dropbox:School "/home/$USER/Documents/School" -P'
alias vencord='sh -c "$(curl -sS https://vencord.dev/install.sh)"'

# Convert video to optimized GIF
togif() {
  if [ -z "$1" ]; then
    echo "Usage: togif input.mp4 [fps] [width]"
    return 1
  fi

  local input="$1"
  local output="${input%.*}.gif"
  local fps="${2:-15}"
  local width="${3:-480}"

  ffmpeg -i "$input" -vf "fps=$fps,scale=$width:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$output"
}
```

# LibreOffice
Don't forget to install LibreOffice Math.

Set UI Mode to "Tabbed Compact". Under "View" enable the Menubar.

Increase: Shift+Ctrl+:
Decrease: Shift+Ctrl+;