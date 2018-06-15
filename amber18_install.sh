#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Tested in LinuxMint 18.3

### Amber18 (optional) + AmberTools18 ###
echo "### Iniciando instalação do AmberTools18 + Amber18 ###"

# Set true in whatever you need to install
amber="true"
mpi="true"
cuda="true"
cuda_version="cuda9"
gpus=1

place=`pwd`
mpi_cores=$(grep -c ^processor /proc/cpuinfo)

apt install -y bc csh flex gfortran g++ xorg-dev zlib1g-dev libbz2-dev patch openmpi-bin libopenmpi-dev

# Download AmberTools18 and/or Amber18 (or put this files in the same folder than this script)
if [ "$amber" = "true" ]; then
  #wget Amber18.tar.bz2 # Get Amber18
  #wget AmberTools18.tar.bz2 Get AmberTools18
  tar xvfj AmberTools18.tar.bz2 -C /opt/
  tar -vzxf Amber18.tgz
  cp -rv Amber18/* /opt/amber18
  rm -r Amber18/
else
  #wget AmberTools18.tar.bz2 Get AmberTools18
  tar xvfj AmberTools18.tar.bz2 -C /opt/
fi

# Gnu - This one you ever need to compile!
export AMBERHOME=/opt/amber18
cd $AMBERHOME
yes | ./configure gnu
source $AMBERHOME/amber.sh
make install

cp amber.sh /etc/profile.d/amber18.sh

if [ "$mpi" = "true" ]; then
  yes | ./configure -mpi gnu
  export DO_PARALLEL="mpirun -np $mpi_cores"
  echo "export DO_PARALLEL=\"mpirun -np $mpi_cores\"" >> amber.sh
  make install
fi

if [ "$cuda" = "true" ]; then
  sh $cuda_version\_install.sh

  source /etc/profile.d/$cuda_version.sh

  export CUDA_VISIBLE_DEVICES=0
  yes | ./configure -cuda gnu
  make install

  if [ "$gpus" -gt 1 ]; then
    export DO_PARALLEL="mpirun -np $gpus"
    export CUDA_VISIBLE_DEVICES=0,1
    yes | ./configure -cuda -mpi gnu
    make install
  fi
fi

## Amber Tests ##
#make test.serial
#make test.parallel
#make test.cuda
#make test.cuda_parallel
#################

cd $place
rm Amber*

echo "Para que as váriáveis do Amber funcionem corretamente para todos os \
usuários é necessário reiniciar o computador."
echo "### Fim da instalação do AmberTools18 e Amber18 ###"
####################
