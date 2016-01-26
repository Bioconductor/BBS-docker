#!/bin/bash

# be sure BIOC_VERSION is set in environment.

if [ -z ${BIOC_VERSION+x} ]; then echo "BIOC_VERSION is unset"; exit 1; else echo "BIOC_VERSION is set to '$BIOC_VERSION'"; fi

docker rm -f BBSdata 
docker run \
  -e "BIOC_VERSION=$BIOC_VERSION" \
  -ti --name BBSdata -v /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc \
  -v $(pwd)/biocdir:/xfer \
  -v $(pwd):/startup \
  -v $HOME/dev/github/BBS-gitsvn:/home/biocbuild/BBS \
  -v $HOME/dev/github/BBS-gitsvn/manage-BioC-repos:/home/biocadmin/manage-BioC-repos \
 ubuntu  /startup/runOnDataVolume.sh