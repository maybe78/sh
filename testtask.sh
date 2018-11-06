#!/bin/bash
# pack all files in inbox folder into a compressed tarball
# outbox/<date>/<time>-files.tar.gz
# where <date> and <time> is the modification date and time of inbox.

FILENAME=$(date -jn -r inbox "+./outbox/%d-%m-%Y/%H:%M:%S")
tar cvz -f $FILENAME.tar.gz api-samples/*

# Look through all files ending with .log inside inbox, and put all lines that start with error: into a file:
# outbox/<date>/<time>-errors.txt

FILENAME=$(date -jn -r inbox "+./outbox/%d-%m-%Y/%H:%M:%S")
grep -h ^error\: ./outbox/*.log >filename

# Remove all files from inbox.

grep -h ^error\: ./outbox/*.log >filename
rm -rvf ./inbox/*

echo "$FILENAME archive success."
