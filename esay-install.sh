# Run example: " ./esay-install.sh --[username] --[enable|disable]

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
	echo "The package wget is NOT installed! Wegt will be installed in 5 seconds! (Press Ctrl + C to cancel)"
	sleep 5
	apt install wget
fi

cat /var/tmp/easy-install/count.txt
if [ $? -ne 0 ]; then
	# first run
	mkdir /var/tmp/easy-install/
	touch /var/tmp/easy-install/count.txt

	wget -O /var/tmp/easy-install/Debian-Scripts.zip "https://github.com/Sparkle-Fuchs/Debian-Scripts/archive/refs/heads/main.zip"
	unzip -d /var/tmp/easy-install /var/tmp/easy-install/Debian-Scripts.zip

	chmod +x /var/tmp/easy-install/Debian-Scripts-main/User_Setup_And_Command_Line.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Free_AMD_Graphics_Drivers.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Useful_User_Applications.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Sublime_Text.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Spotify.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Steam.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Discord-Update.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Visual_Studio_Code.sh
	chmod +x /var/tmp/easy-install/Debian-Scripts-main/Install-Unity3D.sh

	echo "Customization for main user and installation of useful terminal tools."
	sleep 2
#	/var/tmp/easy-install/Debian-Scripts-main/User_Setup_And_Command_Line.sh $1

	echo "adding 32 bit libraries..."
	sleep 2
#	/var/tmp/easy-install/Debian-Scripts-main/Install-Free_AMD_Graphics_Drivers.sh

else
	# second run

	echo "install standard software..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Install-Useful_User_Applications.sh

	echo "install sublime..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Install-Sublime_Text.sh

	echo "install spotify..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Install-Spotify.sh

	echo "install steam..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Install-Steam.sh

	echo "install discord and discord-update-service..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Discord-Update.sh $2

	echo "install Visual Studio Code..."
	sleep 2
	/var/tmp/easy-install/Debian-Scripts-main/Install-Visual_Studio_Code.sh

	echo "install unity..."
	sleep 2
	#/var/tmp/easy-install/Debian-Scripts-main/Install-Unity3D.sh

	rm -rf /var/tmp/easy-install
fi

exit
