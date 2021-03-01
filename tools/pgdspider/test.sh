#!/bin/bash

# Try running the PGDSpider2-cli.jar  and see if it is returns PGDSpider.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
/usr/bin/java -Xmx1024m -Xms512m -jar /opt/pgdspider/PGDSpider2-cli.jar | grep PGDSpider >> /dev/null

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
