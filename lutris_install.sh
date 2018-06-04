#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Tested in: LinuxMint 18.3

# Lutris installation

# Getting distro release
ver=$(lsb_release -sr)

if [ $ver != "17.10" -a $ver != "17.04" -a $ver != "16.04" ]; then
  ver=16.04
fi

echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" > /etc/apt/sources.list.d/lutris.list

wget -q http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | apt-key add -

apt update

apt install -y lutris
