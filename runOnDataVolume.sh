#!/bin/bash

# be sure BIOC_VERSION is set in environment when starting container

if [ -z ${BIOC_VERSION+x} ]; then echo "BIOC_VERSION is unset"; exit 1; else echo "var is set to '$var'"; fi



cp -r /xfer/* /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc
chmod -R a+rw /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc
# echo "about to sleep forever"
# tail -f /dev/null