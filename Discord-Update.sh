#!/bin/bash

dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "wget is installed! Dependencies complete!"
  echo -e "Discord will be updated shortly..."
	sleep 3

	#Create temporary directory / Temporäres Verzeichnis erstellen
	mkdir /var/discord

	#Download latest version (.deb) / Aktuelle Version von Discord (.deb) herunderladen
	wget -O /var/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"

	#Install latest version / Installiere aktuelle Version von Discord 
	apt install /var/discord/discord-installer.deb
	echo -e "Discord is now up to date! Please wait for clean up..."
	sleep 3

	#Clean up / Aufräumen
	rm -rf /var/discord/
else
    echo "The package wget is NOT installed! Please install wget and try again."
fi

exit
