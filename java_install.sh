#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

### Ubuntu ###
# add-apt-repository ppa:webupd8team/java
##############

### Debian ###

# Use this in Debian Stretch
apt remove gnupg
apt install --reinstall gnupg2
apt install dirmngr
#

echo -e \
"#Oracle Java 8 Repository
deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"\
> /etc/apt/sources.list.d/java8.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
##############

apt update

apt install oracle-java8-installer

apt install oracle-java8-set-default
