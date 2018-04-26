#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Tested in: Debian 9 (with no graphic interface)

#Getting the distro name and codename
distro=$(lsb_release --id --short)
distro_codename=$(lsb_release --codename --short)

### Cuda 9.1 ###
echo "### Starting Cuda 9.1 installation ###"
apt install build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

# Getting Cuda 9.1
wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux -O cuda_9.1.85_387.26_linux.run
# Getting Cuda 9.1 Updates (Patch 1, 2 and 3)
wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/1/cuda_9.1.85.1_linux -O cuda_9.1.85.1_linux.run
wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/2/cuda_9.1.85.2_linux -O cuda_9.1.85.2_linux.run
wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/3/cuda_9.1.85.3_linux -O cuda_9.1.85.3_linux.run

chmod 755 cuda_9.1.85*

# Cuda 9.1 Toolkit
./cuda_9.1.85_387.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-9.1" --no-opengl-libs
# Patch 1
./cuda_9.1.85.1_linux.run --silent --accept-eula --installdir="/opt/cuda-9.1"
# Patch 2
./cuda_9.1.85.2_linux.run --silent --accept-eula --installdir="/opt/cuda-9.1"
# Patch 3
./cuda_9.1.85.3_linux.run --silent --accept-eula --installdir="/opt/cuda-9.1"

# Export environment variables
#echo '# Cuda 9.1' > /etc/profile.d/cuda.sh
#echo 'export CUDA_HOME="/opt/cuda-9.1"' >> /etc/profile.d/cuda.sh
#echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda.sh
#echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda.sh

#echo "Para que as váriáveis do CUDA funcionem corretamente para todos os \
#usuários é necessário reiniciar o computador ou executar 'source /etc/profile.d/cuda.sh'."
#echo "### Finish Cuda 9.1 installation ###"
##############
