#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

distro="$(lsb_release --id --short)"

if [ "$distro" = "Debian" ]; then
  distro_codename="$(lsb_release --id --short)"
  if ["$distro_codename" = "stretch"]; then
    apt remove gnupg
    apt install --reinstall gnupg2
    apt install dirmngr
  fi

  echo -e \
  "#Oracle Java 8 Repository
  deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
  deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"\
  > /etc/apt/sources.list.d/java8.list

  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

elif [ "$distro" = "Ubuntu" ]; then
  add-apt-repository ppa:webupd8team/java
elif [ "$distro" = "LinuxMint" ]; then
  add-apt-repository ppa:webupd8team/java
else
  echo "Operating System doesn't known by script"
fi

apt update
apt install oracle-java8-installer
apt install oracle-java8-set-default
