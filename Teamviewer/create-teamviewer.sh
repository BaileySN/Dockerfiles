#!/bin/bash

docker build -t teamviewer .
docker run --rm --net=host --privileged -t -i -v /tmp/.X11-unix:/tmp/.X11-unix teamviewer
