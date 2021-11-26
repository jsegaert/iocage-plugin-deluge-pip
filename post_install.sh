#!/bin/sh

# Prepare the system
pw useradd -n deluge -u 8675309 -m -c "Deluge BitTorrent Client" -s /usr/sbin/nologin -w no
mkdir -p /home/deluge/.config/deluge     
chown -R deluge:deluge /home/deluge/

mkdir /Downloads
chown deluge:deluge /Downloads

# Install the packages
pip install --upgrade pip
pip install deluge

# Install fix for https://dev.deluge-torrent.org/ticket/3278
patch -F 0 /usr/local/lib/python3.8/site-packages/deluge/argparserbase.py /usr/local/etc/deluge_changeset_1b4ac88ce.patch
patch -F 0 /usr/local/lib/python3.8/site-packages/deluge/i18n/util.py /usr/local/etc/deluge_changeset_d6c96d.patch

# Configure the services
sysrc -f /etc/rc.conf deluged_enable="YES"
sysrc -f /etc/rc.conf deluged_user="deluge"

sysrc -f /etc/rc.conf deluge_web_enable="YES"
sysrc -f /etc/rc.conf deluge_web_user="deluge"

echo "The initial password for the WebUI is: deluge" > /root/PLUGIN_INFO
echo "To change, login and you will be prompted." >> /root/PLUGIN_INFO
echo "The default download directory is: /Downloads" >> /root/PLUGIN_INFO

# Start the services
service deluged start
service deluge_web start

