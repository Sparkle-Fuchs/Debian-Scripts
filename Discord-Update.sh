#!/bin/bash

echo -e "Discord wird in kürze aktuallisiert..."
sleep 3

#Create temporary directory / Temporäres Verzeichnis erstellen
mkdir /var/discord

#Aktuelle Version von Discord (.deb) herunderladen / Download latest version (.deb)
wget -O /var/discord/discord-installer.deb "https://discord.com/api/download/stable?platform=linux&format=deb"

#Installiere aktuelle Version von Discord / install latest version 
apt install /var/discord/discord-installer.deb
echo -e "Discord wurde aktuallisiert..."
sleep 3

#Aufräumen / clean up
rm -rf /var/discord/
exit