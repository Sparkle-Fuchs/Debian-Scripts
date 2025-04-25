#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

echo -e "Note: This script will be install Visual Studio Code!"

#check for wget
dpkg -s wget &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "wget is installed! Dependencies complete!"
else
    echo "The package wget is NOT installed! Wegt will be installed in 5 seconds! (Press Ctrl + C to cancel)"
    sleep 5
    apt install wget
fi

#check for apt-transport-https
dpkg -s apt-transport-https &> /dev/null
if [ $? -eq 0 ]; then
  echo -e "apt-transport-https is installed! Dependencies complete!"
else
    echo "The package apt-transport-https is NOT installed! Apt-transport-https will be installed in 5 seconds! (Press Ctrl + C to cancel)"
    sleep 5
    apt install apt-transport-https
fi

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

apt update
apt install code

echo "Visual Studio Code is installed!"

exit
