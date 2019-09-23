#!/bin/bash

# Try to load sismonr and create an in silico system with 5 genes.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
Rscript -e "library(sismonr); test = createInSilicoSystem(G = 5)"

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi


