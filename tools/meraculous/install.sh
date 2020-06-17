#!/bin/bash

# This program is to set up a docker image for Meraculous-2D.
# It assumes a Debian 9 base image has been used for the container.

set -e # exit early if one the commands fails
set -x # echo commands as they're run so that debugging is easier

VERSION=2.2.6

# install dependencies
apt-get -y update
apt-get -y install \
                build-essential \
                cmake \
                libboost-all-dev \
                liblog-log4perl-perl \
                libpackage-constants-perl \
                gnuplot \
                wget \
                bc

# download
mkdir -p /tmp/meraculous
cd /tmp/meraculous
wget https://sourceforge.net/projects/meraculous20/files/Meraculous-v"$VERSION".tar.gz/download
mv download Meraculous-v$VERSION.tar.gz
tar -xzf Meraculous-v$VERSION.tar.gz
cd Meraculous-v$VERSION

# install
./install.sh /opt/meraculous

# clean up
rm -rf /tmp/meraculous

# add MERACULOUS_ROOT=/opt/meraculous to .bashrc for root user
echo 'export MERACULOUS_ROOT=/opt/meraculous' >> ~/.bashrc
