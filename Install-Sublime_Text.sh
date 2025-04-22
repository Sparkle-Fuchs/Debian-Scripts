#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

echo -e "Sublime Text is an alternative for Notepad++, which is not available for Linux."
read -p "This script will install Sublime Text on your system. If you want to install Sublime, please press ENTER to continue."

apt update && apt upgrade

dpkg -s apt-transport-https &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "apt-transport-https is installed! Dependencies complete!"
else
	echo "The package apt-transport-https is NOT installed! apt-transport-https will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	apt install apt-transport-https
fi

dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "wget is installed! Dependencies complete!"
else
	echo "The package wget is NOT installed! wget will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	apt install wget
fi

# Download and install the GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

# Add Sublime Text repository to package sources list
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update apt sources and install Sublime Text
apt update
apt install sublime-text -y

exit
