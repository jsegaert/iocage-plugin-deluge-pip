#!/bin/sh

# Prepare the system
pw useradd -n deluge -u 8675309 -m -c "Deluge BitTorrent Client" -s /usr/sbin/nologin -w no
mkdir -p /home/deluge/.config/deluge     
chown -R deluge:deluge /home/deluge/

mkdir /Downloads
chown deluge:deluge /Downloads

# Install the system
pip install --upgrade pip
pip install deluge

# Configure the services
sysrc -f /etc/rc.conf deluged_enable="YES"
sysrc -f /etc/rc.conf deluged_user="deluge"

sysrc -f /etc/rc.conf deluge_web_enable="YES"
sysrc -f /etc/rc.conf deluge_web_user="deluge"

echo "Deluge Web UI Password: deluge" > /root/PLUGIN_INFO
echo "To change, login and you will be prompted." >> /root/PLUGIN_INFO

echo "Deluge Web UI Password: deluge" > /root/PLUGIN_INFO
echo "To change, login and you will be prompted." >> /root/PLUGIN_INFO

# Start the services
service deluged start
service deluge_web start
