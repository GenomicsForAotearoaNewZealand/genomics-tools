#!/bin/bash
# This program is to set up a cloud image for GBS Data demultiplexing using combinatorial bar codes.
# It depends on a standard Debian 9 cloud instance.

# Install demultiplexer
apt-get -y install  axe-demultiplexer
