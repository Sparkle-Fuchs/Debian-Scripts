#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

sudo usermod -aG sudo $1

apt install fish
chsh -s /usr/bin/fish $1

apt update
apt upgrade

apt install htop tree lolcat

apt install firefox-esr webhttrack lynx filezilla
apt install vlc calibre calibre-bin obs-studio okteta
apt install thunderbird thunderbird-l10n-de thunderbird-l10n-en-gb

apt install handbrake handbrake-cli
apt install gimp gimp-help-en gimp-help-de

#apt install pulseaudio

#apt install install widelands widelands-data
#apt install dolphin-emu
#apt install yuzu
#apt install mgba-qt mgba-sdl mgba-common

#Installation VM-Ware
#apt install linux-headers-$(uname -r) gcc make patch wget pkexec -y
#firefox https://www.if-not-true-then-false.com/2024/debian-vmware-install/"

#KDE Tools
#apt install kde-spectacle kde-style-breeze kde-style-oxygen-qt5 kde-style-qtcurve-qt5 kcolorchooser kolourpaint elisa kalzium krdc kcharselect kalarm

#wget -qO- https://updates.phcode.io/linux/installer.sh | bash

apt install keepassxc
firefox https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
firefox https://addons.mozilla.org/de/firefox/addon/ublock-origin/
#firefox https://addons.mozilla.org/de/firefox/addon/languagetool/
#firefox https://addons.mozilla.org/de/firefox/addon/keepa/
#firefox https://addons.mozilla.org/de/firefox/addon/jdownloader/
#firefox https://addons.mozilla.org/de/firefox/addon/single-file/

exit
