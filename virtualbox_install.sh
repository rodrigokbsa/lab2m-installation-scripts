#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# This script you need to run as root. sudo maybe can't work.

HOW_TO_USE="
Usage: $0 [-sc | -mc | -c | -g | -h | -v]
-s  | --stable            Install the latest stable VirtualBox version
-l  | --latest            Install the latest VirtualBox version (recommended)
-h  | --help              Show this message
-v  | --version           Show the program version

Example:  sudo $0 --latest
          sudo $0 --stable
"

while test -n "$1"; do

  case "$1" in
    -s | --stable )
      vbox_version=$(wget -qO - 'http://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT')
    ;;
    -l | --latest )
      vbox_version=$(wget -qO - 'http://download.virtualbox.org/virtualbox/LATEST.TXT')
    ;;
    -h | --help )
      echo "$HOW_TO_USE"
      exit 1
    ;;
    -v | --version )
      echo "Version 0.3"
      exit 1
    ;;
  esac

  shift
done

apt autoremove -y virtualbox*

distro="$(lsb_release --id --short)"
distro_codename="$(lsb_release --codename --short)"

if [ "$distro" = "LinuxMint" ]; then
  source /etc/os-release
  distro_codename="$UBUNTU_CODENAME"
fi

echo "### Starting VirtualBox $vbox_version installation ###"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian $distro_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
apt update
apt install -y virtualbox-${vbox_version:0:3}
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
wget -c https://download.virtualbox.org/virtualbox/$vbox_version/Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack --accept-license=56be48f923303c8cababb0bb4c478284b688ed23f16d775d729b89a2e8e5f9eb
rm Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
echo "### VirtualBox $vbox_version installation finished ###"
