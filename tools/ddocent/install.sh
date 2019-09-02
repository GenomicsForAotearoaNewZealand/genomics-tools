#!/bin/bash

# This program is to set up a docker container for the tool dDocent version 2.7.8.
# It depends on a standard Debian 9 docker image.

apt-get install -y locales wget freebayes stacks trimmomatic mawk bwa samtools vcftools bio-rainbow seqtk cd-hit bedtools libvcflib1 libvcflib-tools gnuplot parallel bamtools openjdk-11-jre-headless git

# Sort local issues

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

# Download and install dDocent
cd /tmp
git clone https://github.com/relshire/dDocent.git
mv ./dDocent /opt/

#sudo chown debian:debian /opt/dDocent

echo '# The following puts the dDocent installation in the user path.' >> ~/.bashrc
echo 'export PATH="/opt/dDocent/bin:$PATH"' >> ~/.bashrc
