#!/bin/sh

echo BIOC_VERSION is $BIOC_VERSION 

cp -r /xfer/* /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc
chmod -R a+rw /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc
# echo "about to sleep forever"
# tail -f /dev/null