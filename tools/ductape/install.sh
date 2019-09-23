#!/bin/bash

# This program is to set up a docker image for the DuctApe 0.17.13
# It assumes a Debian 9 base image has been used for the container.

# install ductape
apt-get install -y python-numpy python-scipy python-sklearn python-matplotlib python-biopython python-networkx python3-networkx python3-numpy python3-scipy python3-matplotlib ncbi-blast+
apt-get install -y python-pip
pip install DuctApe


