#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

# VMD 1.9.2 installation
wget -c http://www.ks.uiuc.edu/Research/vmd/vmd-1.9.2/files/final/vmd-1.9.2.bin.LINUXAMD64-RHEL5.opengl.tar.gz

tar -vzxf vmd-1.9.2.bin.LINUXAMD64-RHEL5.opengl.tar.gz

cd vmd-1.9.2
sed -i 's/$install_bin_dir=.*/$install_bin_dir="\/opt\/vmd\/bin"/' configure
sed -i 's/$install_library_dir=.*/$install_library_dir="\/opt\/vmd\/lib"/' configure

./configure

cd src
make install

# Export environment variables
echo '# VMD 1.9.2' > /etc/profile.d/vmd.sh
echo 'export VMD_HOME="/opt/vmd"' >> /etc/profile.d/vmd.sh
echo 'export PATH="${PATH}:${VMD_HOME}/bin"' >> /etc/profile.d/vmd.sh
