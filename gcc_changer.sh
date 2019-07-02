#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

HOW_TO_USE="
Usage: $0 [-sc | -mc | -c | -g | -h | -v]
-s  | --select-version      Here you put the gcc and g++ version
-h  | --help                Show this message
-v  | --version             Show the program version

Example: sudo $0 --select-version 6
"
version="7"

while test -n "$1"; do

  case "$1" in
    -s | --select-version )
      version="$2"
      shift
    ;;
    -h | --help )
      echo "$HOW_TO_USE"
      exit 1
    ;;
    -v | --version )
      echo "Version 1.3"
      exit 1
    ;;
  esac

  shift
done

apt install -y gcc-"$version" g++-"$version" gfortran-"$version"

rm /usr/bin/gcc
rm /usr/bin/g++
rm /usr/bin/gfortran

ln -s /usr/bin/gcc-"$version" /usr/bin/gcc
ln -s /usr/bin/g++-"$version" /usr/bin/g++
ln -s /usr/bin/gfortran-"$version" /usr/bin/gfortran
