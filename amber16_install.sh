#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

### Amber16 (optional) + AmberTools17 ###
echo "### Iniciando instalação do AmberTools17 + Amber16 ###"

# Set true in whatever you need to install
amber="true"
mpi="true"
cuda="true"
gpus="2"

place=`pwd`
mpi_cores=$(grep -c ^processor /proc/cpuinfo)

apt install -y csh flex patch gfortran g++ make xorg-dev bison libbz2-dev openmpi-bin libopenmpi-dev

# Download AmberTools17 and/or Amber16 (or put this files in the same folder than this script)
if [ "$amber" = "true" ]; then
  #wget Amber16.tar.bz2 # Get Amber16
  #wget AmberTools17.tar.bz2 Get AmberTools17
  tar xvfj AmberTools17.tar.bz2 -C /opt/
  tar xvfj Amber16.tar.bz2 -C /opt/
else
  #wget AmberTools17.tar.bz2 Get AmberTools17
  tar xvfj AmberTools17.tar.bz2 -C /opt/
fi

# Gnu - This one you ever need to compile!
export AMBERHOME=/opt/amber16
cd $AMBERHOME
yes | ./configure gnu
source $AMBERHOME/amber.sh
make install

cp amber.sh /etc/profile.d/amber.sh

if [ "$mpi" = "true" ]; then
  yes | ./configure -mpi gnu
  export DO_PARALLEL="mpirun -np $mpi_cores"
  echo "export DO_PARALLEL=\"mpirun -np $mpi_cores\"" >> amber.sh
  make install
fi

if [ "$cuda" = "true" ]; then
  source /etc/profile.d/cuda.sh

  export CUDA_VISIBLE_DEVICES=0
  yes | ./configure -cuda gnu
  make install

  export DO_PARALLEL="mpirun -np $gpus"
  export CUDA_VISIBLE_DEVICES=0,1
  yes | ./configure -cuda -mpi gnu
  make install
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
echo "### Fim da instalação do AmberTools17 e Amber16 ###"
####################
