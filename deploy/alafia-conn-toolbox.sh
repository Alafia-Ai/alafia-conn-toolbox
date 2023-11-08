#!/bin/bash

# CONN Toolbox runs inside of a Matlab container, which uses a GUI by default

docker run \
	--interactive \
	--tty \
	--rm \
	--platform=amd64 \
	--environment="DISPLAY=${DISPLAY}"
	--hostname="conn-toolbox" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix" \
	alafia-conn-toolbox:latest

