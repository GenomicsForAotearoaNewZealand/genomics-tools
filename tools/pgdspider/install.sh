#!/bin/bash

# This program is to set up a docker image for the PGDspider version  2.1.1.5.
# It assumes a Debian 8 base image has been used for the container.

set -e # exit early if one the commands fails
set -x # echo commands as they're run so that debugging is easier

VERSION=2.1.1.5

# install dependencies
apt-get -y update
apt-get -y install \
                openjdk-7-jre-headless \
                wget \
                unzip

# download PGDspider
mkdir -p /tmp/pgdspider
cd /tmp/pgdspider
wget http://www.cmpg.unibe.ch/software/PGDSpider/PGDSpider_$VERSION.zip
unzip PGDSpider_2.1.1.5.zip

# install to the /opt directory as per our standards
mkdir  -p /opt/pgdspider
mv ./PGDSpider_$VERSION/* /opt/pgdspider

# clean up
apt-get clean
apt-get -y remove --purge wget unzip
rm -rf /tmp/pgdspider
