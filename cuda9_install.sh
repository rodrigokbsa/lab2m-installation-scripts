#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

#Getting the distro name and version
distro=$(lsb_release --id --short)
version=$(lsb_release --codename --short)

### Cuda 9 ###
echo "### Starting Cuda 9 installation ###"
apt install build-essential linux-source linux-headers-$(uname -r) linux-image-$(uname -r)
#apt source linux-image-$(uname -r)

# Getting Cuda 9
#wget -c https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
#mv cuda_9.0.176_384.81_linux-run cuda_9.0.176_384.81_linux.run

./cuda_9.0.176_384.81_linux.run --silent --driver --toolkit --toolkitpath="/opt/cuda-9.0" --no-opengl-libs
#q accept y y n y /opt/cuda-9.0 y n

# Export environment variables
echo '# Cuda 9.0' > /etc/profile.d/cuda.sh
echo 'export CUDA_HOME="/opt/cuda-9.0"' >> /etc/profile.d/cuda.sh
echo 'export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"' >> /etc/profile.d/cuda.sh
echo 'export PATH="${PATH}:${CUDA_HOME}/bin"' >> /etc/profile.d/cuda.sh

echo "Para que as váriáveis do CUDA funcionem corretamente para todos os \
usuários é necessário reiniciar o computador ou executar 'source /etc/profile.d/cuda.sh'."
echo "### Finish of Cuda 9 installation ###"
##############
