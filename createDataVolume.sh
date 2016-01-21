#!/bin/bash

# be sure BIOC_VERSION is set in environment.

docker rm -f BBSdata ; \
docker run -ti --name BBSdata -v /home/biocbuild/public_html/BBS/$BIOC_VERSION/bioc \
  -v $(pwd)/biocdir:/xfer \
  -v $(pwd):/startup \
  -v $HOME/dev/github/BBS-gitsvn:/home/biocbuild/BBS \
  -v $HOME/dev/github/BBS-gitsvn/manage-BioC-repos:/home/biocadmin/manage-BioC-repos \
 busybox  /startup/runOnDataVolume.sh