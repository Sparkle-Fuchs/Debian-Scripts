#!/bin/bash

echo -e "This script is used to easily and automatically update the Discord client. Unfortunately, it still does not have a repository. If Discord is not installed on the target system, this script will install Discord automatically."
echo -e "Note: This script requires the wget and curl packages. If wget or curl are not installed, this script will install wget and curl!"

#is wget installed?
dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "wget is installed! Dependencies complete!"
else
    echo "The package wget is NOT installed! Wegt will be installed now!"
    sleep 5
    apt install wget
fi

#is curl installed?
dpkg -s curl &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "curl is installed! Dependencies complete!"
else
    echo "The package curl is NOT installed! Curl will be installed now!"
    sleep 5
    apt install curl
fi

echo "All Dependencies complete!"

#Is Discord installed?
dpkg -s discord &> /dev/null
if [ $? -eq 0 ]; then

	#Get remote version and location
	LocationString=$(curl --location --head 'https://discord.com/api/download/stable?platform=linux&format=deb' | grep "location:")
	echo -e "The location of the latest version is: " $LocationString
 	#Select version number
	VersionRemote=$(echo "$LocationString" | cut -d '/' -f 6)
	echo -e "The latest version is: discord" $VersionRemote

	#Get installed version
	VersionLocal=$(dpkg-query -f '${Version}' -W discord)
	echo -e "Currently installed is: discord" $VersionLocal


	#Check for a newer version
	if test $VersionLocal != $VersionRemote; then echo "Discord $VersionRemote is newer than Discord $VersionLocal"; fi

	if test $VersionLocal != $VersionRemote; then
 
		echo -e "Discord will be updated shortly..."
		sleep 1

		#Create temporary directory / Temporäres Verzeichnis erstellen
		mkdir /var/discord

		#Download latest version (.deb) / Aktuelle Version von Discord (.deb) herunderladen
  		echo -e "Download Discord $VersionRemote"
		wget -O /var/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"

		#Install latest version / Installiere aktuelle Version von Discord 
		apt install /var/discord/discord-installer.deb
		echo -e "Discord is now up to date! Please wait for clean up..."
		sleep 1

		#Clean up / Aufräumen
		rm -rf /var/discord/

	else
		#Discord can not be update, because the latest version is installed
    		echo "The package discord is already up to date!"

	fi

else
	#Discord can not be update, because Discord is not installed
    	echo "The package discord is NOT installed! Discorad will be installed now!"

	#Create temporary directory / Temporäres Verzeichnis erstellen
	mkdir /var/discord

	#Download latest version (.deb) / Aktuelle Version von Discord (.deb) herunderladen
	wget -O /var/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"

	#Install latest version / Installiere aktuelle Version von Discord 
	apt install /var/discord/discord-installer.deb
	sleep 1

	#Clean up / Aufräumen
	rm -rf /var/discord/

  	echo -e "Discord is installed!"
fi

exit
