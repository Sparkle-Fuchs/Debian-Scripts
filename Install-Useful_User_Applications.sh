#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

apt update

apt install firefox-esr webhttrack lynx filezilla
apt install vlc calibre calibre-bin obs-studio okteta
apt install thunderbird thunderbird-l10n-de thunderbird-l10n-en-gb

apt install handbrake handbrake-cli
apt install gimp gimp-help-en gimp-help-de

#apt install pulseaudio

apt install keepassxc

firefox https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
firefox https://addons.mozilla.org/de/firefox/addon/ublock-origin/
#firefox https://addons.mozilla.org/de/firefox/addon/languagetool/
#firefox https://addons.mozilla.org/de/firefox/addon/keepa/
#firefox https://addons.mozilla.org/de/firefox/addon/jdownloader/
#firefox https://addons.mozilla.org/de/firefox/addon/single-file/

exit
