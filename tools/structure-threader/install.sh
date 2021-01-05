#!/bin/bash

# This program is to set up a docker image for structure_threader 1.0.0.
# It assumes a Debian 10 base image has been used for the container.

set -e # exit early if one the commands fails
set -x # echo commands as they're run so that debugging is easier

VERSION=1.0.0

# install dependencies
apt-get -y update
apt-get -y install \
                python3 \
                python3-pip \
                build-essential

# install via pip3
pip3 install structure_threader

# clean up
apt-get remove --purge -y build-essential
