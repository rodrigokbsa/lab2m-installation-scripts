#!/bin/bash
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

### Cuda 9 ###
echo "### Starting Cuda 9 installation ###"

HOW_TO_USE="
Usage: $0 [ -c | -h | -v ]
-c | --choose-version   Here you can put the Cuda 9 version you want to use. (Ex.: --choose-version 9.1. Available: 8.0, 9.0, 9.1, 9.2 -> default.)
-h | --help             Show this message
-v | --version          Show the program version
"

check_version() {
  version="$1"
  if test -z "$version"; then
    version="9.2"
  fi
}

while test -n "$1"; do

  case "$1" in
    -c | --choose-version )
      shift
      version="$1"

      check_version "$version"
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

check_version "$version"
#Getting the distro name
distro=$(lsb_release --id --short)
distro_codename="$(lsb_release --codename --short)"
# Show the default display manager
#cat /etc/X11/default-display-manager

apt install -y build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

case "$version" in
  "9.2")
    # Getting Cuda 9.2
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux -O cuda_9.2.88_396.26_linux.run
    # Getting Cuda 9.2 Updates (Patch 1 - May 16th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/patches/1/cuda_9.2.88.1_linux -O cuda_9.2.88.1_linux.run

    chmod +x cuda_9.2.88*

    # Cuda 9.2 Toolkit
    if [ "$distro" = "LinuxMint" -o "$distro" = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.2.88_396.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    else
      ./cuda_9.2.88_396.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.2.88.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
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
    if [ "$distro" = "LinuxMint" -o "$distro" = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.1.85_387.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    else
      ./cuda_9.1.85_387.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.1.85.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
    # Patch 2
    ./cuda_9.1.85.2_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
    # Patch 3
    ./cuda_9.1.85.3_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
  ;;
  "9.0")
    # Getting Cuda 9.0
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run -O cuda_9.0.176_384.81_linux.run
    # Getting Cuda 9.0 Updates (Patch 1 and 2 - Mar 5th 2018)
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda_9.0.176.1_linux-run -O cuda_9.0.176.1_linux.run
    wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda_9.0.176.2_linux-run -O cuda_9.0.176.2_linux.run

    chmod +x cuda_9.0.176*

    # Cuda 9.0 Toolkit
    if [ "$distro" = "LinuxMint" -o "$distro" = "Ubuntu" ]; then
      # In this case you need to install the drivers via Driver Manager before it.
      ./cuda_9.0.176_384.81_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    else
      ./cuda_9.0.176_384.81_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$version" --no-opengl-libs
    fi
    # Patch 1
    ./cuda_9.0.176.1_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
    # Patch 2
    ./cuda_9.0.176.2_linux.run --silent --accept-eula --installdir="/opt/cuda-$version"
  ;;
  "8.0")
  # Getting Cuda 8.0
  wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
  # Getting Cuda 8.0 Update (Patch 2 - Jun 26th 2017)
  wget -c https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run -O cuda_8.0.61.2_linux-run -O cuda_8.0.61.2_linux.run

  chmod +x cuda_8.0.61*

  # Solving errors with perl libs in Debian Stretch and Ubuntu Xenial
  if [ "$distro_codename" = "stretch" -o "$distro_codename" = "xenial" -o "$distro" = "LinuxMint" ]; then
    ./cuda_8.0.61*.run --tar mxvf
    cp -rv InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base/
    export "$PERL5LIB"
  fi

  if [ $distro = "LinuxMint" -o $distro = "Ubuntu" ]; then
    # In this case you need to install the drivers via Driver Manager before it.
    ./cuda_8.0.61_375.26_linux.run --silent --toolkit --toolkitpath="/opt/cuda-$version" --override --no-opengl-libs
  else
    ./cuda_8.0.61_375.26_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-$version" --override --no-opengl-libs
  fi
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
