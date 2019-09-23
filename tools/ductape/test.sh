#!/bin/bash

# Try /usr/local/bin/dape  and see if it is returns DuctApe.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
/usr/local/bin/dape --version | grep dape >> /dev/null


if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
