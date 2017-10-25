#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

#Getting the distro name
distro=$(lsb_release --id --short)

### Cuda 8 ###
echo "### Iniciando instalação do Cuda 8 ###"
apt install -y build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#You need to "Enable source code repositories" in Linux Mint and Ubuntu before run the script
#sudo software-sources - Linux Mint
apt source linux-image-$(uname -r)

# You must stop any X services like gdm, gdm3 or lightdm for example. In this case we're using Lightdm in Linux Mint 18.2
#service gdm stop
#service gdm3 stop
#service lightdm stop

# Getting Cuda 8
wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
mv cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
# Getting Cuda 8 Update
wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run
mv cuda_8.0.61.2_linux-run cuda_8.0.61.2_linux.run
chmod +x cuda*

# Uncomment below to solve some errors with perl libs in Debian Stretch and Ubuntu Xenial
#./cuda*.run --tar mxvf
#cp -rv InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/
#export $PERL5LIB

# Don't use the --driver tag in Linux Mint or Ubuntu (Use the system's drivers)
./cuda_8.0.61_375.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-8.0" --override --no-opengl-libs
#q accept y y n y /opt/cuda-8.0 y n
./cuda_8.0.61.2_linux.run --silent --accept-eula --installdir="/opt/cuda-8.0"
#q accept /opt/cuda-8.0

# Export environment variables
echo '# Cuda 8.0' > /etc/profile.d/cuda.sh
echo 'export CUDA_HOME="/opt/cuda-8.0"' >> /etc/profile.d/cuda.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda.sh

##############
