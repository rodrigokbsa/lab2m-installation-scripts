#!/bin/bash
# Autor: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

echo "### Iniciando instalação do Chimera ###"

wget -c 'https://www.cgl.ucsf.edu/chimera/cgi-bin/secure/chimera-get.py?ident=OHeQer2VSqRn%2F%2BBltntD5uBjvkFERNv%2B3hJ00A7gie4orQ%3D%3D&file=linux_x86_64%2Fchimera-1.13.1-linux_x86_64.bin&choice=Notified' -O chimera-1.13.1-linux_x86_64.bin
chmod +x chimera-1.13.1-linux_x86_64.bin
./chimera-1.13.1-linux_x86_64.bin

echo "### Fim da instalação do Chimera ###"
