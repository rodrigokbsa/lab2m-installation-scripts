#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

echo "### Iniciando instalação do Atom ###"
apt install -y git
wget https://atom.io/download/deb
mv deb atom-amd64.deb
dpkg -i atom-amd64.deb
rm atom-amd64.deb
echo "### Fim da instalação do Atom ###"
