#!/bin/bash

# Try see if file exists in /opt/meraculous/bin.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.

if [ -f /opt/meraculous/bin/meraculous.pl ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi