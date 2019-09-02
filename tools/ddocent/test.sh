#!/bin/bash

# Try to run dDocent with -help and see if it returns dDocent in the string.
# If it does, then put GFANZ_TEST_RESULTS=OK into syslog. If it does not, then 
# put GFANZ_TEST_RESULTS=ERROR into syslog.

source /opt/miniconda2/bin/activate ddocent_env

dDocent -help | grep dDocent >> /dev/null

if [ $? -eq 0 ]; then
  echo GFANZ_TEST_RESULTS=OK
else
  echo GFANZ_TEST_RESULTS=ERROR
fi
