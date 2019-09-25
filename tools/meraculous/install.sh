#!/bin/bash

# This program is to set up a docker image for Meraculous-2D.
# It assumes a Debian 9 base image has been used for the container.

apt-get -y install wget

# download and install Meraculous

cd /tmp
mkdir meraculous
cd meraculous/
wget https://sourceforge.net/projects/meraculous20/files/latest/download
mv download Meraculous-v2.2.6.tar.gz
tar -xzf Meraculous-v2.2.6.tar.gz
apt-get install -y build-essential cmake libboost-all-dev liblog-log4perl-perl gnuplot
./install.sh /opt/meraculous