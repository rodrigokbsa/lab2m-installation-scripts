#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

distro="$(lsb_release --id --short)"

if [ "$distro" = "LinuxMint" ]; then
  source /etc/os-release
  distro_codename=$UBUNTU_CODENAME
else
  distro_codename="$(lsb_release --codename --short)"
fi

apt install dkms
echo "### Iniciando instalação do VirtualBox 5.1 ###"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian $distro_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y virtualbox-5.1
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
wget -c http://download.virtualbox.org/virtualbox/5.1.30/Oracle_VM_VirtualBox_Extension_Pack-5.1.30-118389.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.1.30-118389.vbox-extpack --accept-license=b674970f720eb020ad18926a9268607089cc1703908696d24a04aa870f34c8e8
rm Oracle_VM_VirtualBox_Extension_Pack-5.1.30-118389.vbox-extpack
echo "### Fim da instalação do VirtualBox 5.1 ###"
