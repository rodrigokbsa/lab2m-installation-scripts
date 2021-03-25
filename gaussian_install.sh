#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

place="$PWD"
g16root='/opt'
gauss_scrdir='/home/scr_tmp'
group='g16'

HOW_TO_USE="
In the actual version we were installing only Gaussian 16.

Usage: $0 [-d | -l | -g | -h | -v]
-d  | --default           Default instalation for gaussian binaries
-l  | --linda             Not implemented yet - multicore
-g  | --gpu               Not implemented yet (This script works only with binaries, for this method we need a source code)
-h  | --help              Show this message
-v  | --version           Show the program version

Example: sudo $0 --default
"

while test -n "$1"; do

  case "$1" in
    -d | --default )
      default="true"
    ;;
    -l | --linda )
      exit 1
    ;;
    -g | --gpu )
      exit 1
    ;;
    -h | --help )
      echo "$HOW_TO_USE"
      exit 1
    ;;
    -v | --version )
      echo "Version 21.03"
      exit 1
    ;;
  esac

  shift
done

### Gaussian 16 with binaries ###
echo "### Starting installation ###"

apt install -y csh

mkdir $g16root
mkdir $gauss_scrdir
chmod 775 $gauss_scrdir

tar xvfJ $place/tar/*.tbJ -C $g16root

addgroup $group # Create gaussian 16 group
gpasswd -a $USER $group # Add current user to the group

chgrp -R $group "$g16root/g16" #chgrp -R <grp> g16
chgrp -R $group "$gauss_scrdir"

cd $g16root/g16
bsd/install

echo '# Gaussian 16' > /etc/profile.d/gaussian16.sh
echo "export g16root="$g16root"" >> /etc/profile.d/gaussian16.sh
echo "export GAUSS_SCRDIR="$gauss_scrdir"" >> /etc/profile.d/gaussian16.sh
echo '. $g16root/g16/bsd/g16.profile' >> /etc/profile.d/gaussian16.sh

cd "$place"

echo "To the environment works corretly you need to logoff. Without this you have to run 'source /etc/profile.d/gaussian16.sh' in each single terminal session."
echo 'After that use "sudo gpasswd -a $user g16" to add the users in the new gaussian16 group'
echo "### Installation finished ###"
####################
