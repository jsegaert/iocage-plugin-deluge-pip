# iocage-plugin-deluge-pip
Artifact file(s) for Deluge iocage plugin

This plugin will install Deluge and its WebUI from the Python Package Index (PyPI)

## To install this Plugin
Download the plugin manifest file to your local file system.
```
fetch https://raw.githubusercontent.com/jsegaert/iocage-my-plugins/master/deluge-pip.json
```
Install the plugin.  Adjust the network settings as needed.
```
iocage fetch -P deluge-pip.json -n deluge
```



