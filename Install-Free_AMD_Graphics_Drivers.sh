#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Error: This script requires root privileges. Please run with sudo."
	exit 1
fi

lscpu | grep "AMD"
if [ $? -eq 0 ]; then
#	apt install amd64-microcode
	echo "1"
fi

lspci -nn | grep VGA | grep AMD
if [ $? -eq 0 ]; then
#	AMD Grafikkarte erkannt
	apt purge '*nvidia*'
	apt update
	apt install firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all
	dpkg --add-architecture i386 && apt update
	apt install libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
	apt install lm-sensors radeontop
fi

exit
