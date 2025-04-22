#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

apt update && apt upgrade

dpkg -s apt-transport-https &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "apt-transport-https is installed! Dependencies complete!"
else
	echo "The package apt-transport-https is NOT installed! Apt-transport-https will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install apt-transport-https
fi

dpkg -s curl &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "curl is installed! Dependencies complete!"
else
	echo "The package curl is NOT installed! Curl will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install curl
fi

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update
apt install spotify-client

exit
