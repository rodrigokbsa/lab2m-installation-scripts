#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

sudo apt install zip gnat gawk gperf autogen guile texinfo ecj1 antlr  #libgtk2.0-dev c++98

# Download GCC5 -> https://gcc.gnu.org/
#wget -c http://gcc.parentingamerica.com/releases/gcc-5.4.0/gcc-5.4.0.tar.bz2
tar -jxvf gcc-*.tar.bz2
#rm gcc-*.tar.bz2

cd gcc-5.4.0

# Download GMP 4.2+ -> https://gmplib.org/
#wget -c https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
apt install lzip
lzip -d gmp-*.tar.lz
tar -xvf gmp-*.tar
#rm gmp-*.tar
mv gmp-* gmp

# Download MPFR 2.4+ -> http://www.mpfr.org/
#wget -c http://www.mpfr.org/mpfr-current/mpfr-3.1.5.tar.bz2
tar -jxvf mpfr-*.tar.bz2
#rm mpfr-*.tar.bz2
mv mpfr-* mpfr

# Download MPC 0.8+ -> http://www.multiprecision.org/
#wget -c ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
tar -vzxf mpc-*.tar.gz
#rm mpc-*.tar.gz
mv mpc-* mpc

# --with-gmp --with-mpfr --with-mpc
./configure --disable-multilib --prefix=/home/rodrigof/gcc-5.4.0/compilado
make
