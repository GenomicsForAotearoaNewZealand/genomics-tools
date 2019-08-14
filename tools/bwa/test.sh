#!/bin/bash

# Try which bwa and see if it is installed.
# If it does, then put GFANZ_TEST_RESULTS=OK into syslog. If it does not, then 
# put GFANZ_TEST_RESULTS=ERROR into syslog.
which bwa | grep /usr/bin/bwa >> /dev/null

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
