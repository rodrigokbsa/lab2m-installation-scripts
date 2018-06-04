#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

#Getting the distro name
distro=$(lsb_release --id --short)
distro_codename="$(lsb_release --codename --short)"

### Cuda 8 ###
echo "### Iniciando instalação do Cuda 8 ###"
apt install -y build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#You need to "Enable source code repositories" in Linux Mint and Ubuntu before run the script
#sudo software-sources - Linux Mint
apt source linux-image-$(uname -r)

# Getting Cuda 8
wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
# Getting Cuda 8 Update
wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run -O cuda_8.0.61.2_linux-run -O cuda_8.0.61.2_linux.run

chmod +x cuda_8.0.61*

# Solving errors with perl libs in Debian Stretch and Ubuntu Xenial
if [ "$distro_codename" = "stretch" -o "$distro_codename" = "xenial" -o "$distro" = "LinuxMint" ]; then
  ./cuda_8.0.61*.run --tar mxvf
  cp -rv InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/
  export $PERL5LIB
fi

# You must stop any X services like gdm, gdm3 or lightdm for example.
#cat /etc/X11/default-display-manager
#service mdm stop
#service kdm stop
#service gdm stop
#service gdm3 stop
#service lightdm stop

# Don't use the --driver tag in Linux Mint or Ubuntu (Install the system's drivers before cuda)
if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
  ./cuda_8.0.61_375.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-8.0" --override --no-opengl-libs
else
  ./cuda_8.0.61_375.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-8.0" --override --no-opengl-libs
fi
./cuda_8.0.61.2_linux.run --silent --accept-eula --installdir="/opt/cuda-8.0"

# Export environment variables
echo '# Cuda 8.0' > /etc/profile.d/cuda8.sh
echo 'export CUDA_HOME="/opt/cuda-8.0"' >> /etc/profile.d/cuda8.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda8.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda8.sh

##############
