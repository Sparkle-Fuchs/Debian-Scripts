#!/bin/bash

dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "wget is installed! Dependencies complete!"
  echo -e "Discord will be updated shortly..."
	sleep 3

	#Create temporary directory / Temporäres Verzeichnis erstellen
	mkdir /var/discord

	#Aktuelle Version von Discord (.deb) herunderladen / Download latest version (.deb)
	wget -O /var/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"

	#Installiere aktuelle Version von Discord / install latest version 
	apt install /var/discord/discord-installer.deb
	echo -e "Discord is now up to date! Please wait for clean up..."
	sleep 3

	#Aufräumen / clean up
	rm -rf /var/discord/
else
    echo "The package wget is NOT installed! Please install wget and try again."
fi

exit
