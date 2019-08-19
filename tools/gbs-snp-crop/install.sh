#!/bin/bash

# This program is to set up a docker image for the tool GBS-SNP-CROP version 4.0.
# It assumes a Debian 9 base image has been used for the container.

# Install GBS-SNP-CROP dependencies from Debian
apt-get -y install trimmomatic vsearch bwa samtools openjdk-8-jre git

# Install Dependencies that are not documented
apt-get install -y libparallel-forkmanager-perl liblist-moreutils-perl

# Install gbs-snp-crop
cd /opt/
git clone https://github.com/halelab/GBS-SNP-CROP.git

# Make the perl scripts executable.
chmod +x /opt/GBS-SNP-CROP/GBS-SNP-CROP-scripts/v.4.0/*.pl

# Put GBS-SNP-CROP version 4 scripts in the default user path so that the user can run them.
echo '# The following puts the GBS-SNP-CROP scripts in the user path.' >> ~/.bashrc
echo 'export PATH="/opt/GBS-SNP-CROP/GBS-SNP-CROP-scripts/v.4.0:$PATH"' >> ~/.bashrc
