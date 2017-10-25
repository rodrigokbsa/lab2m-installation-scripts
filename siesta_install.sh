#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Base Founded at https://pelios.csx.cam.ac.uk/~mc321/siesta.html and improved

echo "### Starting Siesta's installation ###"

mkdir /opt/siesta-4.0.1
mkdir /opt/siesta-4.0.1/bin
siesta_bin="/opt/siesta-4.0.1/bin/"
distro="$(lsb_release --id --short)"

if [ "$distro" = "Debian" ]; then
  echo 'Installing Debian dependencies'
  apt install openmpi-common openmpi-bin libopenmpi-dev libblacs-openmpi1 libopenmpi1.6 libnetcdf-dev netcdf-bin libscalapack-openmpi1 libscalapack-mpi-dev libblas-common libblas-dev liblapack-dev -y
elif [ "$distro" = "Ubuntu" ]; then
  echo 'Installing Ubuntu dependencies'
  apt install openmpi-common openmpi-bin libopenmpi-dev libblacs-mpi-dev libopenmpi1.6 libnetcdf-dev netcdf-bin libnetcdff-dev libscalapack-mpi-dev libblas-dev liblapack-dev -y
elif [ "$distro" = "LinuxMint" ]; then
  echo 'Installing Linux Mint dependencies'
  apt install openmpi-common openmpi-bin libopenmpi-dev libblacs-mpi-dev libopenmpi1.6 libnetcdf-dev netcdf-bin libnetcdff-dev libscalapack-mpi-dev libblas-dev liblapack-dev -y
else
  echo "Operating System doesn't known by script"
  echo 'Browse for the dependencies to be installed.'
fi

wget -c https://launchpad.net/siesta/4.0/4.0.1/+download/siesta-4.0.1.tar.gz

tar zxf siesta-4.0.1.tar.gz
cd siesta-4.0.1/Obj

sh ../Src/obj_setup.sh

# Generating serial
cd ../Src
./configure
cp arch.make ../Obj
cd ../Obj
make
mv siesta $siesta_bin

# Generating parallel
cd ../Src
./configure --enable-mpi
sed -i '9s/^.SUFFIXES:.*/.SUFFIXES: .f .F .o .a .f90 .F90/' arch.make
sed -i 's/^SIESTA_ARCH=.*/SIESTA_ARCH=x86_64-unknown-linux-gnu--Gfortran/' arch.make
sed -i 's/^RANLIB=.*/RANLIB=echo/' arch.make
sed -i 's/^FPPFLAGS=.*/FPPFLAGS= -DMPI -DFC_HAVE_FLUSH -DFC_HAVE_ABORT -DCDF -DGRID_DP -DPHI_GRID_SP/' arch.make
sed -i '/^BLAS_LIBS=.*/i INCFLAGS=-I/usr/include -I. -I/usr/lib/openmpi/include/' arch.make
sed -i 's/^BLAS_LIBS=.*/BLAS_LIBS=-lblas/' arch.make
sed -i 's/^LAPACK_LIBS=.*/LAPACK_LIBS=/usr/lib/lapack/liblapack.a/' arch.make
sed -i 's/^BLACS_LIBS=.*/BLACS_LIBS=-lblacsF77init-openmpi -lblacsCinit-openmpi -lblacs-openmpi/' arch.make
sed -i 's/^SCALAPACK_LIBS=.*/SCALAPACK_LIBS=-lscalapack-openmpi/' arch.make
sed -i 's/^NETCDF_LIBS=.*/NETCDF_LIBS=-lnetcdff -lnetcdf/' arch.make
sed -i 's/^NETCDF_INTERFACE=.*/NETCDF_INTERFACE=libnetcdf_f90.a/' arch.make
sed -i 's/^LIBS=.*/LIBS= $(NETCDF_LIBS) -lpthread $(SCALAPACK_LIBS) $(BLACS_LIBS) $(LAPACK_LIBS) $(BLAS_LIBS)/' arch.make
cp arch.make ../Obj
cd ../Obj
make
mv siesta $siesta_bin/siesta-parallel
# Downloading arch.make for parallel
#wget https://pelios.csx.cam.ac.uk/~mc321/arch.make.deb_or_ubuntu --no-check-certificate
#mv arch.make.deb_or_ubuntu arch.make

echo '# Siesta 4.0.1' > siesta.sh
echo 'export SIESTA_HOME="/opt/siesta-4.0.1"' >> siesta.sh
echo 'export PATH="${PATH}:${SIESTA_HOME}/bin"' >> siesta.sh
mv siesta.sh /etc/profile.d/

echo "Restart the computer or run 'source /etc/profile.d/siesta.sh' to read the environments"
echo "### End of Siesta's installation ###"
