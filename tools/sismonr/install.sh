#!/bin/bash

# This program is to set up a docker image for the R package sismonr 1.1.4.
# It assumes a Debian 9 base image has been used for the container.

# Install julia
apt-get update
apt-get install -y wget
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz
tar xvzf julia-1.0.5-linux-x86_64.tar.gz
ln -s $(pwd)/julia-1.0.5/bin/julia /usr/local/bin/julia

# Enable the CRAN repository and add the CRAN GPG key to your system by running the following commands:
apt-get -y install dirmngr apt-transport-https ca-certificates software-properties-common gnupg2 build-essential
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys FCAE2A0E115C3D8A
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian stretch-cran35/'

# update the packages list and install the R package
apt update
apt install -y r-base

# Test that the correct version of R is installed
R --version | grep '3.6.2'
if [ $? -eq 0 ]; then
  echo "Correct R version"
else
  echo "Incorrect R version"
  exit 1
fi

# Install the R package checkpoint globally
Rscript -e "install.packages('sismonr', repos='https://cran.stat.auckland.ac.nz')"
