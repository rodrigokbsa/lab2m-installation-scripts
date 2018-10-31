#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# This script you need to run as root. sudo don't work.

vbox_version="5.2.20"
distro="$(lsb_release --id --short)"
distro_codename="$(lsb_release --codename --short)"

if [ "$distro" = "LinuxMint" ]; then
  source /etc/os-release
  distro_codename="$UBUNTU_CODENAME"
fi

apt autoremove -y virtualbox*

echo "### Starting VirtualBox 5.2 installation ###"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian $distro_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y dkms virtualbox-5.2
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
wget -c https://download.virtualbox.org/virtualbox/$vbox_version/Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack --accept-license=56be48f923303c8cababb0bb4c478284b688ed23f16d775d729b89a2e8e5f9eb
rm Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
echo "### VirtualBox 5.2 installation finished ###"
