#!/bin/bash 
# This program is to set up a cloud image for the tool seqhax.
# It depends on a Debian 9 base docker image.

# The following packages are dependecies for seqhax and scripts we expect to use.
# seqhax operates on single files but can take advantage of multiple cores using parallel.
apt-get -y install byobu htop git zlib1g-dev cmake build-essential libboost-dev parallel

# Download and install seqhax
cd /tmp
git clone https://github.com/kdmurray91/seqhax.git
cd seqhax
mkdir build && cd build
cmake ..
make
make install

mv /usr/local/bin/seqhax /opt/
