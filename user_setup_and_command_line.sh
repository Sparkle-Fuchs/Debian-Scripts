#!/bin/bash

#This script adds any user (transfer parameter '--[username]' ) as a sudoer. It also installs a few useful programs for the command line. This Skript musst run as user root ( "su" ) or with an sudoers user.


# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

UserName=$(echo "$1" | cut -d '-' -f 3)

# Check for user
if test -n "$1" ; then
	sudo usermod -aG sudo $UserName
	apt update
	apt install fish -y && chsh -s /usr/bin/fish $UserName
	echo $UserName "was privileged as sudoer and the default shell was changed to fish."
	else
	echo "Error: This script requires the specification of a user. You can specify a user as follows: '--[username]'."
	exit 2
fi

dpkg -s htop &> /dev/null
if [ $? -eq 0 ]; then
	echo "htop is installed!"
else
	echo "The package htop is NOT installed! htop will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install htop
fi

dpkg -s btop &> /dev/null
if [ $? -eq 0 ]; then
	echo "btop is installed!"
else
	echo "The package btop is NOT installed! btop will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install btop
fi

dpkg -s iftop &> /dev/null
if [ $? -eq 0 ]; then
	echo "iftop is installed!"
else
	echo "The package iftop is NOT installed! iftop will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install iftop
fi

dpkg -s tree &> /dev/null
if [ $? -eq 0 ]; then
	echo "tree is installed!"
else
	echo "The package tree is NOT installed! tree will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install tree
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

dpkg -s fastfetch &> /dev/null
if [ $? -eq 0 ]; then
	echo "fastfetch is installed!"
else

	lsb_release -a | grep "Debian GNU/Linux 12" &> /dev/null
	if [ $? -eq 0 ]; then
		#firefox https://github.com/fastfetch-cli/fastfetch
		wget -O /tmp/fastfetch.deb "https://github.com/fastfetch-cli/fastfetch/releases/download/2.41.0/fastfetch-linux-amd64.deb"
		apt install /tmp/fastfetch.deb && rm -rf /tmp/fastfetch.deb
	else
		apt install fastfetch
	fi
fi

dpkg -s lolcat &> /dev/null
if [ $? -eq 0 ]; then
	echo "lolcat is installed!"
else
	echo "The package lolcat is NOT installed! lolcat will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install lolcat
fi

exit
