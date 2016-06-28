
Build the Container with docker
docker build -t firefox-esr .


Command for starting the Container and Display in your X11 Enviroment Firefox
docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       firefox-esr
