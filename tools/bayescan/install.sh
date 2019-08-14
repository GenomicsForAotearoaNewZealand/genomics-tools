#!/bin/bash
# This program is to set up a cloud image for the BayeScan from http://cmpg.unibe.ch/software/BayeScan/download.html.
# The bayescan executable is /opt/bayescan2.1/bayescan and is in the path.

# It depends on a standard Debian 9 cloud instance.

# install not listed dependencies
apt-get -y install unzip wget

# create temporary folders, get the zip file and unzip it

mkdir /tmp/install

cd /tmp/install

wget http://cmpg.unibe.ch/software/BayeScan/files/BayeScan2.1.zip

unzip BayeScan2.1.zip

# make the executable directory in opt, move binary there

mkdir /opt/bayescan2.1

mv /tmp/install/BayeScan2.1/binaries/BayeScan2.1_linux64bits /opt/bayescan2.1/bayescan

chmod +x /opt/bayescan2.1/bayescan
