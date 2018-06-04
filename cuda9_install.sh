#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Tested in: Debian 9 (without graphic interface) and LinuxMint 18.3

#Getting the distro name
distro=$(lsb_release --id --short)

### Cuda 9.2 ###
echo "### Starting Cuda 9.2 installation ###"
apt install build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

# Getting Cuda 9.2
wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux -O cuda_9.2.88_396.26_linux.run
# Getting Cuda 9.2 Updates (Patch 1 - May 16th 2018)
wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/patches/1/cuda_9.2.88.1_linux -O cuda_9.2.88.1_linux.run

chmod +x cuda_9.2.88*

# Cuda 9.2 Toolkit
if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
  # In this case you need to install the drivers via Driver Manager before it.
  ./cuda_9.2.88_396.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-9.2" --no-opengl-libs
else
  ./cuda_9.2.88_396.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-9.2" --no-opengl-libs
fi
# Patch 1
./cuda_9.2.88.1_linux.run --silent --accept-eula --installdir="/opt/cuda-9.2"

# Export environment variables
echo '# Cuda 9.2' > /etc/profile.d/cuda9.sh
echo 'export CUDA_HOME="/opt/cuda-9.2"' >> /etc/profile.d/cuda9.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda9.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda9.sh

echo "To the environment works corretly in every user you need to restart this computer or execute 'source /etc/profile.d/cuda9.sh' in each single terminal session."
echo "### Finish Cuda 9.2 installation ###"
##############
