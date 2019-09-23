#!/bin/bash

# This program is to set up a docker image for mosdepth 0.2.6.
# It assumes a Debian 9 base image has been used for the container.

# install mosdepth
wget https://github.com/brentp/mosdepth/releases/download/v0.2.6/mosdepth && chmod +x ./mosdepth
