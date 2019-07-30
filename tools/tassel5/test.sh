#!/bin/bash

# TASSEL5 needs to be called using /opt/tassel5-src/run_pipeline.pl in the scripts. This is because it needs
# to access the libs which it thinks are relative to its position.

# Try to run the pipeline without arguments and see if it returns the parseArgs string.
# If it does, then put GFANZ_TEST_RESULTS=OK into syslog. If it does not, then 
# put GFANZ_TEST_RESULTS=ERROR into syslog.

/opt/tassel5-src/run_pipeline.pl | grep parseArgs >> /dev/null

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
