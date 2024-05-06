#!/bin/bash

image=${1:-eagle962}

# docker run -P -v ${PWD}/nick:/home/nick -t -i $image /bin/bash
# docker run -d -P $image

docker run -ti \
	--rm \
	-e DISPLAY=:0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v "/home/nick/.eaglerc:/home/user/.eaglerc" \
	-v "/home/nick/Priv/Eagle:/home/user/Priv/Eagle" \
	-v "/home/nick/Downloads:/home/user/downloads" \
	$image /bin/bash
