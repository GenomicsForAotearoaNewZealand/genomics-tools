#!/bin/bash

# This program is to set up a docker container for the tool dDocent version 2.7.8.
# It depends on a standard Debian 10 docker image.

apt-get install -y locales wget freebayes stacks trimmomatic mawk bwa samtools vcftools bio-rainbow seqtk cd-hit bedtools libvcflib-tools gnuplot parallel bamtools openjdk-11-jre-headless fastp git

# dDocent calls rainbow, but debian calls that programme bio-rainbow. 
# make a soft link from /usr/bin/rainbow /usr/bin/bio-rainbow
ln -s /usr/bin/bio-rainbow /usr/bin/rainbow

# Sort local issues

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

# Download and install dDocent 
# NOTE This version is one that I modified to remove the requirement for PEAR 
# It does not have full functionality.
cd /tmp
git clone -b disablePEAR https://github.com/relshire/dDocent.git
mv ./dDocent /opt/

#sudo chown debian:debian /opt/dDocent

echo '# The following puts the dDocent installation in the user path.' >> ~/.bashrc
echo 'export PATH="/opt/dDocent/bin:$PATH"' >> ~/.bashrc
echo '# The following puts the vcfcombine in the user path.' >> ~/.bashrc
echo 'export PATH="/usr/lib/vcflib/bin/:$PATH"' >> ~/.bashrc
