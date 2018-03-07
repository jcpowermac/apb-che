#!/bin/bash


mkdir -p ${HOME}/che/data
mkdir -p ${HOME}/che/sync
mkdir -p ${HOME}/che/unison

sudo docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock:Z \
    -v ${HOME}/che/data:/data \
    -v ${HOME}/che/sync:/sync \
    -v ${HOME}/che/unison:/unison \
    -e CHE_HOST='172.31.51.52' \
    -e CHE_WORKSPACE_VOLUME='/var/run/docker.sock:/var/run/docker.sock:rw,Z;' \
    'eclipse/che:latest' $@
