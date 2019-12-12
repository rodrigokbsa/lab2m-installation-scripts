#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

# VMD 1.9.3 installation
wget -c 'https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.3/files/final/vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz'

tar -vzxf "vmd-1.9.3.bin.LINUXAMD64-CUDA8-OptiX4-OSPRay111p1.opengl.tar.gz"

cd vmd-1.9.3
sed -i 's/$install_bin_dir=.*/$install_bin_dir="\/opt\/vmd\/bin";/' configure
sed -i 's/$install_library_dir=.*/$install_library_dir="\/opt\/vmd\/lib";/' configure

./configure

cd src
make install

# Export environment variables
echo '# VMD 1.9.3' > /etc/profile.d/vmd.sh
echo 'export VMD_HOME="/opt/vmd"' >> /etc/profile.d/vmd.sh
echo 'export PATH="${PATH}:${VMD_HOME}/bin"' >> /etc/profile.d/vmd.sh

echo "To the environment works corretly in every user you need to restart this computer. Without rebooting you have to run 'source /etc/profile.d/vmd.sh' in each terminal session."
