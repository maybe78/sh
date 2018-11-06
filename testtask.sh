#!/bin/bash
# pack all files in inbox folder into a compressed tarball
# outbox/<date>/<time>-files.tar.gz
#
# where <date> and <time> is the modification date and time of inbox.
#
# Look through all files ending with .log inside inbox, and put all lines that start with error: into a file:
# outbox/<date>/<time>-errors.txt
# Remove all files from inbox.

dt=$(date '+%d/%m/%Y %H:%M:%S')
FILENAME=$(date -jn -r inbox "+./outbox/%d-%m-%Y/%H:%M:%S")
tar cvz -f $FILENAME.tar.gz api-samples/*

grep -h ^error\: ./outbox/*.log >$FILENAME-errors.txt
rm -rvf ./inbox/*

echo "$FILENAME archive success."


# The script should exit with code 0 if all operations were completed successfully.  Otherwise, non-zero exit code should be returned.
# The script should not lose or overwrite files.  For example, existing files in outbox should never be overwritten, and files should only be removed from inbox if the .tar.gz archive has been successfully created.
# Make sure to document in comments any assumptions you make about how your script should be used.  Keep your solution simple and try not to overengineer it.
