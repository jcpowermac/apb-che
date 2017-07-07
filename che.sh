#!/bin/bash

docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/jcallen/che/data:/data \
    -v /home/jcallen/che/sync:/sync \
    -v /home/jcallen/che/unison:/unison eclipse/che $@
    

#    -v /home/jcallen/che/data/instance:/data/instance \
#    -v /home/jcallen/che/data/backup:/data/backup \
