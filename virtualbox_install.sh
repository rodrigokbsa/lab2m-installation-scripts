#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

#apt install virtualbox
echo "### Iniciando instalação do VirtualBox 5.1 ###"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" > /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y virtualbox-5.1
wget -c http://download.virtualbox.org/virtualbox/5.1.28/Oracle_VM_VirtualBox_Extension_Pack-5.1.28-117968.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.1.28-117968.vbox-extpack --accept-license=715c7246dc0f779ceab39446812362b2f9bf64a55ed5d3a905f053cfab36da9e
rm Oracle_VM_VirtualBox_Extension_Pack-5.1.28-117968.vbox-extpack
echo "### Fim da instalação do VirtualBox 5.1 ###"
