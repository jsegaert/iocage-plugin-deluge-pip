#!/bin/sh

# Install all needed packages
pkg update
pkg install ca_root_nss python39 py39-boost-libs py39-chardet py39-distro py39-mako py39-pillow py39-pip py39-twisted py39-rencode py39-setproctitle py39-xdg b2 libtorrent-rasterbar portdowngrade rust subversion


# Prepare the system
pw useradd -n deluge -u 8675309 -m -c "Deluge BitTorrent Client" -s /usr/sbin/nologin -w no
mkdir -p /home/deluge/.config/deluge     
chown -R deluge:deluge /home/deluge/

mkdir /Downloads
chown deluge:deluge /Downloads
chown deluge:deluge /mnt/torrent

# Install the packages
pip install --upgrade pip
pip install deluge

# install working py-libtorrent-rasterbar from ports
portsnap fetch update
portsnap fetch extract
portdowngrade net-p2p/py-libtorrent-rasterbar r569235
cd ./py-libtorrent-rasterbar
make deinstall install clean

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

