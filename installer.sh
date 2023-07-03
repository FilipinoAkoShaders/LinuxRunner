set -e

CACHE="/data/data/com.termux/files/home/.linuxrunner.installer"

[ ! -d "$CACHE" ] && mkdir "$CACHE"

TITLE="LinuxRunner [INSTALLER]"
ZENITY="zenity --info --title $TITLE --width 500 --text"

$ZENITY "Installing Depedencies." &
yes | pkg update && yes | pkg upgrade
yes | pkg install zenity zip unzip wget
clear

zenity --question --text "Continue Installation?" --width 500 --title "LinuxRunner [INSTALLER]"

V=$(zenity --entry --text "Version" --width 500 --title "LinuxRunner [INSTALLER]")

$ZENITY "Downloading $V" &
wget "https://github.com/FilipinoAkoShaders/LinuxRunner/releases/download/v${V}/linuxrunner-data.zip" -O "$CACHE"/data.zip

cd "$CACHE"
unzip data.zip
rm data.zip
clear

if [ -d $PREFIX/share/linuxrunner ]; then
$ZENITY "Deleting Old LinuxRunner" &
bash uninstall.sh
clear
fi

$ZENITY "Installing Linux Runner" &
bash install.sh
clear

cd $HOME
rm -rf "$CACHE"

zenity --info --text "Done!" --width 500 --title "LinuxRunner [INSTALLER]"

clear
