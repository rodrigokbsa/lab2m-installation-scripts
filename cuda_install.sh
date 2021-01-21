#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

### Cuda ###
echo "### Starting Cuda installation ###"

HOW_TO_USE="
Installation of CUDA Toolkit - Use Nvidia Drivers provided by system.
Debian 10: apt install nvidia-driver
Ubuntu Focal: apt install nvidia-driver-450 (recommended) (version: 390, 418, 430, 440, 450 and 455 are available)

Usage: $0 [ -c | -h | -v ]
-i | --install-version    Here you can put the Cuda version you want to use. Available: 8.0, [9.2 - default], 10.2 and 11.1
-h | --help               Show this message
-v | --version            Show the program version

Example: sudo $0 --install-version 9.2
"
version="9.2"

while test -n "$1"; do

  case "$1" in
    -i | --install-version )
      shift
      if [ -n "$1" ]; then
        version="$1"
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

distro="$(lsb_release --id --short)"
distro_codename="$(lsb_release --codename --short)"

if [ "$distro" = "LinuxMint" -o "$distro" = "Linuxmint" ]; then
  source /etc/os-release
  distro_codename="$UBUNTU_CODENAME"
fi

apt install -y build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

case "$version" in
  "11.1")
    # Getting Cuda 11.1
    wget https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run

    chmod +x cuda_11.0.3_450.51.06_linux.run

    # Cuda 11.1 Toolkit
    # You need to install the drivers via apt or driver manager.
    ./cuda_11.0.3_450.51.06_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs --override

  ;;
  "10.2")
    # Getting Cuda 10.2
    wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run

    # Getting Cuda 10.2 Updates (Patch 1 - August 26th 2020)
    wget -c http://developer.download.nvidia.com/compute/cuda/10.2/Prod/patches/1/cuda_10.2.1_linux.run

    chmod +x cuda_10.2.*

    # Cuda 10.2 Toolkit
    # You need to install the drivers via apt or driver manager.
    ./cuda_10.2.89_440.33.01_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs --override

    # Patch 1
    ./cuda_10.2.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
  ;;
  "9.2")
    # Getting Cuda 9.2
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux -O cuda_9.2.148_396.37_linux.run
    # Getting Cuda 9.2 Updates (Patch 1 - May 16th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda_9.2.148.1_linux -O cuda_9.2.148.1_linux.run

    chmod +x cuda_9.2.148*

    # Cuda 9.2 Toolkit
    # You need to install the drivers via apt or driver manager.
    ./cuda_9.2.148_396.37_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs --override

    # Patch 1
    ./cuda_9.2.148.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
  ;;
  "8.0")
  # Getting Cuda 8.0
  wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
  # Getting Cuda 8.0 Update (Patch 2 - Jun 26th 2017)
  wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run -O cuda_8.0.61.2_linux-run

  chmod +x cuda_8.0.61*

  # Solving errors with perl libs in Debian Stretch and Ubuntu Xenial
  if [ "$distro_codename" = "stretch" -o "$distro_codename" = "xenial" ]; then
    ./cuda_8.0.61*.run --tar mxvf
    cp -rv InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/
    export "$PERL5LIB"
  fi

  # Cuda 8.0 Toolkit
  # You need to install the drivers via apt or driver manager.
  ./cuda_8.0.61_375.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --override --no-opengl-libs --override

  # Patch 2
  ./cuda_8.0.61.2_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
  ;;
  "*")
    echo "This Cuda Version value isn't recognizeable for the script."
  ;;
esac

# Export environment variables
echo "# Cuda $version" > /etc/profile.d/cuda.sh
echo "export CUDA_HOME=\"/opt/cuda-$version\"" >> /etc/profile.d/cuda.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda.sh

cp "/etc/profile.d/cuda.sh" "/opt/cuda-$version"

echo "To the environment works corretly in every user you need to restart this computer or execute 'source /etc/profile.d/cuda.sh' in each single terminal session."
echo "### Finish Cuda installation ###"
##############
