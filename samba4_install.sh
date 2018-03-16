#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

# Dependencies
sudo apt install -y acl attr autoconf bison build-essential debhelper dnsutils docbook-xml docbook-xsl flex gdb krb5-user libacl1-dev libaio-dev libattr1-dev libblkid-dev libbsd-dev libcap-dev libcups2-dev libgnutls28-dev libjson-perl libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl libpopt-dev libreadline-dev perl perl-modules-5.24 pkg-config python-all-dev python-dev python-dnspython python-crypto xsltproc zlib1g-dev libgpgme-dev python-gpgme python-m2crypto

# Available link in https://www.samba.org/samba/download/
wget https://download.samba.org/pub/samba/stable/samba-4.8.0.tar.gz

tar -zxvf samba-4.8.0.tar.gz

cd samba-4.8.0

#Verificar XATTR
#cat /boot/config-4.9.0-3-amd64 | grep _ACL
#cat /boot/config-4.9.0-3-amd64 | grep FS_SECURITY

# Compiling...
./configure --prefix=/opt/samba
make
make install

# Export environment variables
echo '# Samba 4.8' > /etc/profile.d/samba4.sh
echo 'export SAMBA_HOME="/opt/samba"' >> /etc/profile.d/samba4.sh
echo 'export PATH="${PATH}:${SAMBA_HOME}/bin:${SAMBA_HOME}/sbin"' >> /etc/profile.d/samba4.sh
# Read in .bashrc
echo 'source /etc/profile.d/samba4.sh' >> $HOME/.bashrc
