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
echo "### Iniciando instalação do VirtualBox 5.2 ###"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian $distro_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y virtualbox-5.2
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
wget -c https://download.virtualbox.org/virtualbox/5.2.6/Oracle_VM_VirtualBox_Extension_Pack-5.2.6.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.6.vbox-extpack --accept-license=56be48f923303c8cababb0bb4c478284b688ed23f16d775d729b89a2e8e5f9eb
rm Oracle_VM_VirtualBox_Extension_Pack-5.2.6.vbox-extpack
echo "### Fim da instalação do VirtualBox 5.2 ###"
