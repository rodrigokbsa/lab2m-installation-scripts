#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

place="$PWD"
HOW_TO_USE="
Usage: $0 [-sc | -mc | -c | -g | -h | -v]
-g  | --gnu               Amber and AmberTools18 GNU compilation - singlecore (required)
-m  | --mpi               Amber and AmberTools18 MPI compilation - multicore
-c  | --cuda              Compile Amber18 (Using 1 gpu). If you have more than one gpu just put the number after this tag.
-h  | --help              Show this message
-v  | --version           Show the program version

Example: sudo $0 --gnu --mpi --cuda 2
"

while test -n "$1"; do

  case "$1" in
    -g | --gnu )
      gnu="true"
    ;;
    -m | --mpi )
      mpi="true"
      mpi_cores=$(grep -c ^processor /proc/cpuinfo)
    ;;
    -c | --cuda )
      shift
      cuda="true"
      if [ -z "$1" ]; then
        gpus="1"
      else
        gpus="$1"
      fi
    ;;
    -h | --help )
      echo "$HOW_TO_USE"
      exit 1
    ;;
    -v | --version )
      echo "Version 1.2"
      exit 1
    ;;
  esac

  shift
done

### Amber18 (optional) + AmberTools18 ###
echo "### Starting Amber installation ###"

apt install -y bc csh flex gfortran g++ zlib1g-dev libbz2-dev patch openmpi-bin libopenmpi-dev xorg-dev

export AMBERHOME="/opt/amber18"
amberhome_folders="$(ls $AMBERHOME | wc -l)"

# Download AmberTools18 and/or Amber18 (or put this files in the same folder than this script) (ver se existe pasta vazia em /opt/amber18)
if [ amberhome_folders -ne "29" ]; then
  rm -r $AMBERHOME
  tar xvfj AmberTools18.tar.bz2 -C /opt/
  tar xvfj Amber18.tar.bz2 -C /opt/
fi

cd "$AMBERHOME"
source "$AMBERHOME/amber.sh"

if [ "$gnu" = "true" ]; then
  yes | ./configure gnu
  source "$AMBERHOME/amber.sh"
  make install
fi

if [ "$mpi" = "true" ]; then
  yes | ./configure -mpi gnu
  export DO_PARALLEL="mpirun -np $mpi_cores"
  echo "export DO_PARALLEL=\"mpirun -np $mpi_cores\"" >> "$AMBERHOME"/amber.sh
  make install
fi

# You need to install cuda first by script cuda_install.sh - Amber18 supports 8.0, 9.0, 9.1 and 9.2. Amber need to know where CUDA_HOME environment is.
if [ "$cuda" = "true" ]; then

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
