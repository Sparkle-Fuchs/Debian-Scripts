#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

# Is wget installed?
dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "wget is installed! Dependencies complete!"
else
	echo "The package wget is NOT installed! Wegt will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install wget
fi

# Is steam installed?
dpkg -s steam-launcher &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "Steam is already installed."
else
	echo "The package steam is NOT installed! Steam will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	mkdir /tmp/steam
	wget -O /tmp/steam/steam_latest.deb "https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"
	apt install /tmp/steam/steam_latest.deb -y && rm -rf /tmp/steam/steam_latest.deb
	echo "Steam is now installed!"
fi

	apt update
 	apt install libc6:amd64 libc6:i386 libegl1:amd64 libegl1:i386 libgbm1:amd64 libgbm1:i386 libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1:amd64 libgl1:i386 steam-libs-amd64:amd64 steam-libs-amd64

exit
