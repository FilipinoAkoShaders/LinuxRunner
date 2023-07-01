set -e

CACHE="/data/data/com.termux/files/home/.linuxrunner.installer"

[ ! -d "$CACHE" ] && mkdir "$CACHE"

echo "Installing Dependencies."
yes | pkg update && yes | pkg upgrade
yes | pkg install zenity zip unzip wget
clear

zenity --question --text "Continue Installation?" --width 500 --title "LinuxRunner [INSTALLER]"

V=$(zenity --entry --text "Version" --width 500 --title "LinuxRunner [INSTALLER]")

wget "https://github.com/FilipinoAkoShaders/LinuxRunner/releases/download/v${V}/linuxrunner-data.zip" -O "$CACHE"/data.zip

cd "$CACHE"
unzip data.zip
rm data.zip

bash uninstall.sh
bash install.sh

cd $HOME
rm -rf "$CACHE"

zenity --info --text "Done!" --width 500 --title "LinuxRunner [INSTALLER]"
