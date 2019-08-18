#!/bin/bash

# Try /opt/prokka/bin/prokka  and see if it is returns prokka.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
/opt/prokka/bin/prokka --version 2>&1 | grep prokka >> /dev/null


if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
