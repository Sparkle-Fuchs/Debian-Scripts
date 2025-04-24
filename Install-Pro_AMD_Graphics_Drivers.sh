#!/bin/bash

#Please note that the installation of a proprietary graphics driver is only recommended if it is explicitly required. For example, if it is required by an application or the graphics card is so new that the kernel does not yet have its own driver.

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

lscpu | grep "AMD"
if [ $? -eq 0 ]; then
#	apt install amd64-microcode
	echo "1"
fi

lspci -nn | grep VGA | grep AMD
if [ $? -eq 0 ]; then
#	AMD Grafikkarte erkannt
	apt purge '*nvidia*'
	dpkg --add-architecture i386 && apt update
	mkdir /tmp/amd/
	wget -O /tmp/amd/amdgpu-install.deb "https://repo.radeon.com/amdgpu-install/6.3.4/ubuntu/jammy/amdgpu-install_6.3.60304-1_all.deb"
	apt install /tmp/amd/amdgpu-install.deb
	amdgpu-install -y --usecase=graphics,rocm --vulkan=amdvlk,pro --opencl=rocr,legacy --accept-eula
	sudo usermod -aG render,video $LOGNAME
	rm -rf /tmp/amd
	apt install lm-sensors radeontop
	echo "The AMD Graphics Drivers Pro is now installed!"
 	sudo init 6
fi

exit
