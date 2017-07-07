#!/bin/bash


mkdir -p ${HOME}/che/data
mkdir -p ${HOME}/che/sync
mkdir -p ${HOME}/che/unison

docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${HOME}/che/data:/data \
    -v ${HOME}/che/sync:/sync \
    -v ${HOME}/che/unison:/unison eclipse/che $@
