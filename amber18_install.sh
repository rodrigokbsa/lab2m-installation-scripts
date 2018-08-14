#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

place="$PWD"
HOW_TO_USE="
Usage: $0 [-a | -m | -c | -g | -h | -v]
-a | --amber            Amber18 compiling instead of just AmberTools18
-m | --mpi              Amber and AmberTools18 MPI compiling
-c | --cuda             Install Cuda 9.2 (default) and compile Amber18 for it (Using 1 gpu)
-g | --gpus             If you choose --cuda. You'll use this when you have more than one gpu. (Ex.: --gpus 3 if you have 3 gpus)
-h | --help             Show this message
-v | --version          Show the program version

Example: sudo $0 --amber --mpi --cuda --gpu 2
"

check_gpus() {
  gpus="$1"
  if test -z "$gpus"; then
    echo "You forgot to put how much gpus you have."
    exit 1
  fi
}

while test -n "$1"; do

  case "$1" in
    -a | --amber )
      amber="true"
    ;;
    -m | --mpi )
      mpi="true"
      mpi_cores=$(grep -c ^processor /proc/cpuinfo)
    ;;
    -c | --cuda )
      cuda_version="9.2"
      cuda="true"
      gpus="1"
    ;;
    -g | --gpus )
      shift
      gpus="$1"

      check_gpus "$gpus"
    ;;
    -h | --help )
      echo "$HOW_TO_USE"
      exit 1
    ;;
    -v | --version )
      echo "Version 1.1"
      exit 1
    ;;
  esac

  shift
done

### Amber18 (optional) + AmberTools18 ###
echo "### Starting Amber installation ###"

apt install -y bc csh flex gfortran g++ xorg-dev zlib1g-dev libbz2-dev patch openmpi-bin libopenmpi-dev

# Download AmberTools18 and/or Amber18 (or put this files in the same folder than this script)
if [ "$amber" = "true" ]; then
  #wget Amber18.tar.bz2 # Get Amber18
  #wget AmberTools18.tar.bz2 Get AmberTools18
  tar xvfj AmberTools18.tar.bz2 -C /opt/
  tar xvfj Amber18.tar.bz2 -C /opt/
else
  #wget AmberTools18.tar.bz2 Get AmberTools18
  tar xvfj AmberTools18.tar.bz2 -C /opt/
fi

# Gnu - This one you ever need to compile!
export AMBERHOME="/opt/amber18"
cd "$AMBERHOME"
yes | ./configure gnu
source "$AMBERHOME"/amber.sh
make install

if [ "$mpi" = "true" ]; then
  yes | ./configure -mpi gnu
  export DO_PARALLEL="mpirun -np $mpi_cores"
  echo "export DO_PARALLEL=\"mpirun -np $mpi_cores\"" >> "$AMBERHOME"/amber.sh
  make install
fi

if [ "$cuda" = "true" ]; then
  bash "$place"/cuda_install.sh --choose-version "$cuda_version"

  source /etc/profile.d/cuda.sh

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

cp "$AMBERHOME"/amber.sh /etc/profile.d/amber18.sh

## Amber Tests ##
#make test.serial
#make test.parallel
#make test.cuda
#make test.cuda_parallel
#################

cd "$place"

echo "To the environment works corretly in every user you need to restart this computer. Without rebooting you have to run 'source /etc/profile.d/amber18.sh' in each single terminal session."
echo "### Installation of Amber finished ###"
####################
