#!/bin/bash

# Try to run axe-demux with -V and see if it returns AXE in the string.
# If it does, then put GFANZ_TEST_RESULTS=OK into syslog. If it does not, then 
# put GFANZ_TEST_RESULTS=ERROR into syslog.
/opt/seqhax | grep seqhax >> /dev/null

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
