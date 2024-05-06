#!/bin/bash

image=${1:-eagle962}

# docker run -P -v ${PWD}/nick:/home/nick -t -i $image /bin/bash
# docker run -d -P $image

docker run -ti \
	--rm \
	-e DISPLAY=:0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	$image /bin/bash
