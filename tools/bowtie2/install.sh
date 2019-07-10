#!/bin/bash

# This program is to set up a docker image for the bowtie2 aligner version 2.3.0.
# It assumes a Debian 9 base image has been used for the container.

# install bowtie2
apt-get -y install bowtie2
