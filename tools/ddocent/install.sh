#!/bin/bash

# This program is to set up a docker container for the tool dDocent version 2.7.8.
# It depends on a standard Debian 9 docker image.

apt-get install wget

# Download and install conda
cd /tmp
mkdir /opt/miniconda2
chown debian:debian /opt/miniconda2
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -f -b -p /opt/miniconda2

# Install dDocent
/opt/miniconda2/bin/conda config --add channels r
/opt/miniconda2/bin/conda config --add channels defaults
/opt/miniconda2/bin/conda config --add channels conda-forge
/opt/miniconda2/bin/conda config --add channels bioconda
/opt/miniconda2/bin/conda  create -y -n ddocent_env ddocent

# Put conda in the default user path so that the user can run things installed
# via conda.
echo '# The following puts the miniconda2 installation in the user path.' >> ~/.bashrc
echo 'export PATH="/opt/miniconda2/bin:$PATH"' >> ~/.bashrc
