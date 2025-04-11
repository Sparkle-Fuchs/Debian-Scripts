#!/bin/bash

echo -e "Sublime Text is an alternative for Notepad++, which is not available for Linux."
read -p "This script will install Sublime Text on your system. If you want to install Sublime, please press ENTER to continue."

apt update && apt upgrade -y

#Checking for 
dpkg -s apt-transport-https &> /dev/null
if [ $? -eq 0 ]; then
    #apt-transport-https is installed
else
	#apt-transport-https is not installed
    apt install apt-transport-https -y
fi

dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
  	#wget is installed
else
	#wget is not installed
    apt install wget -y
fi

#Download and install the GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

#Add Sublime Text repository to package sources list
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#Update apt sources and install Sublime Text
apt update
apt install sublime-text -y

exit
