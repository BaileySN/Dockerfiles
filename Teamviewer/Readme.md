## Build Container
```
docker build -t teamviewer .
```

## Start Container and open Teamviewer
```
docker run --rm --net=host --privileged -t -i -v /tmp/.X11-unix:/tmp/.X11-unix teamviewer
```
