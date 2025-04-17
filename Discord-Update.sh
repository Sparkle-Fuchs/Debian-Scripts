#!/bin/bash

Discord-Install-Routine(){
	mkdir /tmp/discord
  	echo -e "Download latest version of Discord."
	wget -O /tmp/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
	apt install /tmp/discord/discord-installer.deb && rm -rf /tmp/discord
}


echo -e "This script is used to easily and automatically update the Discord client. Unfortunately, it still does not have a repository. If Discord is not installed on the target system, this script will install Discord automatically."
echo -e "Note: This script requires the wget and curl packages. If wget or curl are not installed, this script will install wget and curl!"

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
	echo "The package wget is NOT installed! Wegt will be installed now!"
	sleep 5
	apt install wget
fi

# Is curl installed?
dpkg -s curl &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "curl is installed! Dependencies complete!"
else
	echo "The package curl is NOT installed! Curl will be installed now!"
	sleep 5
	apt install curl
fi

# Is Discord installed?
dpkg -s discord &> /dev/null
if [ $? -eq 0 ]; then
	# Get remote version and location
	LocationString=$(curl --location --head 'https://discord.com/api/download/stable?platform=linux&format=deb' | grep "location:")
	echo -e "The location of the latest version is: " $LocationString
 	# Select version number
	VersionRemote=$(echo "$LocationString" | cut -d '/' -f 6)
	echo -e "The latest version is: discord" $VersionRemote

	# Get installed version
	VersionLocal=$(dpkg-query -f '${Version}' -W discord)
	echo -e "Currently installed is: discord" $VersionLocal

	if test $VersionLocal != $VersionRemote; then echo "Discord $VersionRemote is newer than Discord $VersionLocal"; fi

	if test $VersionLocal != $VersionRemote; then
		echo -e "Discord will be updated shortly..."
		Discord-Install-Routine
		echo -e "Discord is now up to date!"
	else
    		echo "The package discord is already up to date!"
	fi
else
    	echo "The package discord is NOT installed! Discorad will be installed now!"
	Discord-Install-Routine
  	echo -e "Discord is installed!"
fi
exit
