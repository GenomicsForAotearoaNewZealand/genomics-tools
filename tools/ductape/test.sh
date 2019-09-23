#!/bin/bash

# Try /usr/local/bin/dape  and see if it is returns DuctApe.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
/usr/local/bin/dape --version 2>&1 | grep dape 
#the output of dape --version is stored in stderr instead of in stdout. This stops grep from finding the correct item for the test. The short command "2>&1" redirect sterr to stdout and allow for the test to work correctly

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
