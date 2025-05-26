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

mkdir /var/tmp/easy-install/
cd /var/tmp/easy-install/
wget -O /var/tmp/easy-install/Debian-Scripts.zip "https://github.com/Sparkle-Fuchs/Debian-Scripts/archive/refs/heads/main.zip"
unzip ./Debian-Scripts.git && cd ./Debian-Scripts-main/
rm ./LICENSE ./README.md ./esay-install.sh ./Install-Tools.sh

files=($(ls))
for file in "${files[@]}"; do
  chmod +x ./$file
  echo $file "is now executable"
done


echo "Customization for main user and installation of useful terminal tools."
sleep 5
./User_Setup_And_Command_Line.sh --sparkle

echo "adding 32 bit libraries..."
sleep 5
./Free_AMD_Graphics_Drivers.sh

echo "install standard software..."
slepp 5
./Useful_User_Applications.sh

echo "install sublime..."
slepp 5
./Install-Sublime_Text.sh

echo "install spotify..."
slepp 5
./Install-Spotify.sh

echo "install steam..."
slepp 5
./Install-Steam.sh

echo "install spotify..."
slepp 5
./Install-Spotify.sh

echo "install discord and discord-update-service..."
slepp 5
./Discord-Update.sh --enable

echo "install Visual Studio Code..."
slepp 5
./Visual_Studio_Code.sh

echo "install unity..."
slepp 5
./Install-Unity3D.sh

rm -rf /var/tmp/easy-install

exit
