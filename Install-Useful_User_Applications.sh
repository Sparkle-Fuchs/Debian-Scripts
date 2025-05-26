#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

apt update

apt install firefox-esr
apt install webhttrack -y
apt install lynx
apt install filezilla filezilla-common libfilezilla-common -y
apt install vlc -y
#apt install calibre calibre-bin
apt install obs-studio obs-plugins -y
apt install okteta -y
apt install thunderbird thunderbird-l10n-de thunderbird-l10n-en-gb -y

apt install handbrake handbrake-cli -y
apt install gimp gimp-help-en gimp-help-de

apt install easytag -y
apt install audacity -y
#apt install pulseaudio

apt install keepassxc fonts-font-awesome -y

# autoremove protection
dpkg -s sddm &> /dev/null
if [ $? -eq 0 ]; then
	apt-mark manual sddm
fi

dpkg -s sddm-theme-debian-breeze &> /dev/null
if [ $? -eq 0 ]; then
	apt-mark manual sddm-theme-debian-breeze
fi

dpkg -s sddm-theme-breeze &> /dev/null
if [ $? -eq 0 ]; then
	apt-mark manual sddm-theme-breeze
fi

dpkg -s kde-plasma-desktop &> /dev/null
if [ $? -eq 0 ]; then
	apt-mark manual kde-plasma-desktop
 	apt install kcolorchooser kde-spectacle -y
fi

echo
echo https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
echo https://addons.mozilla.org/de/firefox/addon/ublock-origin/
echo https://addons.mozilla.org/de/firefox/addon/languagetool/
echo https://addons.mozilla.org/de/firefox/addon/keepa/
echo

exit
