#!/bin/sh
# Author: Rodrigo Fioravante
# Email: kbsafioravante@gmail.com

# install necesary i386 libraries
apt install -y libgtk2.0-0:i386 libstdc++6:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libqt4-qt3support:i386 libgnome-keyring0:i386 libnss-mdns:i386 libnss3:i386

# make keyring visible for Adobe Air
ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

# Download Adobe Air
cd ~/Downloads
#wget -c http://airdownload.adobe.com/air/lin/download/latest/AdobeAIRInstaller.bin
#wget -c http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
wget -c http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2
mkdir /opt/adobe-air-sdk
tar jxf AdobeAIRSDK.tbz2 -C /opt/adobe-air-sdk

# Download Air runtime/SDK from Archlinux
wget -c https://aur.archlinux.org/cgit/aur.git/snapshot/adobe-air.tar.gz
tar xvf adobe-air.tar.gz -C /opt/adobe-air-sdk
chmod +x /opt/adobe-air-sdk/adobe-air/adobe-air

# Get actual scratch file URL from https://scratch.mit.edu/scratch2download/
mkdir /opt/adobe-air-sdk/scratch
wget -c https://scratch.mit.edu/scratchr2/static/sa/Scratch-456.0.4.air
cp Scratch-456.0.4.air /opt/adobe-air-sdk/scratch/
cp Scratch-456.0.4.air /tmp/
cd /tmp/
unzip /tmp/Scratch-456.0.4.air
cp /tmp/icons/AppIcon128.png /opt/adobe-air-sdk/scratch/scratch.png

# Create the Scratch Menu Launcher
cat << _EOF_ > /usr/share/applications/Scratch2.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Exec=/opt/adobe-air-sdk/adobe-air/adobe-air /opt/adobe-air-sdk/scratch/Scratch-456.0.4.air
Icon=/opt/adobe-air-sdk/scratch/scratch.png
Terminal=false
Name=Scratch 2
Comment=Programming system and content development tool
Categories=Application;Education;Development;ComputerScience;
MimeType=application/x-scratch-project
_EOF_

chmod +x /usr/share/applications/Scratch2.desktop
