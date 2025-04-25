#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

apt update

apt install firefox-esr
apt install webhttrack ibhttrack2 webhttrack-common
apt install lynx
apt install filezilla filezilla-common libfilezilla-common -y
apt install vlc -y
#apt install calibre calibre-bin
apt install obs-studio obs-plugins -y
apt install okteta -y
apt install thunderbird thunderbird-l10n-de thunderbird-l10n-en-gb -y

apt install handbrake handbrake-cli -y
apt install gimp gimp-help-en gimp-help-de

#apt install pulseaudio

apt install keepassxc fonts-font-awesome -y

echo https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
echo https://addons.mozilla.org/de/firefox/addon/ublock-origin/
#echo https://addons.mozilla.org/de/firefox/addon/languagetool/
#echo https://addons.mozilla.org/de/firefox/addon/keepa/
#echo https://addons.mozilla.org/de/firefox/addon/jdownloader/
#echo https://addons.mozilla.org/de/firefox/addon/single-file/

exit
