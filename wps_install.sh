#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

echo "### Iniciando instalação do WPS Office ###"
wget -c http://kdl1.cache.wps.com/ksodl/download/linux/a21/wps-office_10.1.0.5707~a21_amd64.deb
wget -c http://wps-community.org/download/dicts/pt_BR.zip
dpkg -i wps-office_10.1.0.5707~a21_amd64.deb
unzip pt_BR.zip
mv pt_BR /opt/kingsoft/wps-office/office6/dicts/
rm -r wps-office_10.1.0.5707~a21_amd64.deb pt_BR.zip
echo "### Fim da instalação do WPS Office ###"
