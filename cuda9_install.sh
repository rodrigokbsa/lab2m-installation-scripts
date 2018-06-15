#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com
# Tested in LinuxMint 18.3

cuda_version="9.0"

#Getting the distro name
distro=$(lsb_release --id --short)

### Cuda 9 ###
echo "### Starting Cuda 9 installation ###"
apt install build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

case $cuda_version in
  "9.2")
    # Getting Cuda 9.2
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux -O cuda_9.2.88_396.26_linux.run
    # Getting Cuda 9.2 Updates (Patch 1 - May 16th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/patches/1/cuda_9.2.88.1_linux -O cuda_9.2.88.1_linux.run

    chmod +x cuda_9.2.88*

    # Cuda 9.2 Toolkit
    if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.2.88_396.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    else
      ./cuda_9.2.88_396.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.2.88.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
  ;;
  "9.1")
    # Getting Cuda 9.1
    wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux -O cuda_9.1.85_387.26_linux.run
    # Getting Cuda 9.1 Updates (Patch 1, 2 and 3 - Mar 5th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/1/cuda_9.1.85.1_linux -O cuda_9.1.85.1_linux.run
    wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/2/cuda_9.1.85.2_linux -O cuda_9.1.85.2_linux.run
    wget -c https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/3/cuda_9.1.85.3_linux -O cuda_9.1.85.3_linux.run

    chmod +x cuda_9.1.85*

    # Cuda 9.1 Toolkit
    if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.1.85_387.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    else
      ./cuda_9.1.85_387.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.1.85.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
    # Patch 2
    ./cuda_9.1.85.2_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
    # Patch 3
    ./cuda_9.1.85.3_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
  ;;
  "9.0")
    # Getting Cuda 9.0
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run -O cuda_9.0.176_384.81_linux.run
    # Getting Cuda 9.0 Updates (Patch 1 and 2 - Mar 5th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda_9.0.176.1_linux-run -O cuda_9.0.176.1_linux.run
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda_9.0.176.2_linux-run -O cuda_9.0.176.2_linux.run

    chmod +x cuda_9.0.176*

    # Cuda 9.0 Toolkit
    if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.0.176_384.81_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    else
      ./cuda_9.0.176_384.81_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$cuda_version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.0.176.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
    ./cuda_9.0.176.2_linux.run --silent --accept-eula --installdir="/opt/cuda-$cuda_version"
  ;;
esac

# Export environment variables
echo "# Cuda $cuda_version" > /etc/profile.d/cuda9.sh
echo "export CUDA_HOME=\"/opt/cuda-$cuda_version\"" >> /etc/profile.d/cuda9.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda9.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda9.sh

echo "To the environment works corretly in every user you need to restart this computer or execute 'source /etc/profile.d/cuda9.sh' in each single terminal session."
echo "### Finish Cuda 9 installation ###"
##############
