#!/bin/sh
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

echo "### Iniciando instalação do Google Chrome ###"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
echo "### Fim da instalação do Google Chrome ###"
