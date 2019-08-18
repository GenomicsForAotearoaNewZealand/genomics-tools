#!/bin/bash

# This program is to set up a docker image for prokka
# It assumes a Debian 10 base image has been used for the container.

# install the dependencies and then remove apt package related stuff to save space.
apt-get install -y libdatetime-perl libxml-simple-perl libdigest-md5-perl git default-jre bioperl build-essential\
	&& rm -rf /var/lib/apt/lists/*

# configure cpan to work without interaction
(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan

# install Bio::Perl
cpan Bio::Perl

# Clone the prokka repo into /opt/
git clone https://github.com/tseemann/prokka.git /opt/prokka

# Set up prokka databases
/opt/prokka/bin/prokka --setupdb
