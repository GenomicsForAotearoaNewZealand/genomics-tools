#!/bin/bash

# This program is to set up a docker image for the TEG modified version of TASSEL5.
# It assumes a Debian 9 base image has been used for the container.

# install bowtie2
apt-get -y install openjdk-8-jdk-headless wget

# Move to /opt for installation of the software
cd /opt

# Get the version of TASSEL5 with modified enzymes
wget --no-check-certificate  "https://data.elshiregroup.co.nz/index.php/s/8yXooTjYiZZeRpS/download" -P /tmp
mv /tmp/download /tmp/tassel5-TEGenzymes.v.2.tar.gz

# Unpack TASSEL5
tar -xzf /tmp/tassel5-TEGenzymes.v.2.tar.gz -C /opt

# Make files readable and executable by all user
chmod -R 755 /opt/tassel5-src
