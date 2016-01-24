#!/bin/bash

docker run -ti --rm -h dockernode \
    -p 8888:80 \
    -p 9191:9191 \
    --name biocbuild \
    -w /home/biocbuild \
    --volumes-from=BBSdata \
    -e USER=biocbuild \
    bioconductor/bbs-docker 
