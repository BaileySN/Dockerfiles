FROM     ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get -q update && \
    apt-get -q upgrade -y && \
    apt-get -q install -y adduser wget ucf procps

RUN wget https://download.teamviewer.com/download/teamviewer_i386.deb -O /tmp/teamviewer_linux.deb && \
    dpkg -i /tmp/teamviewer_linux.deb || apt-get install -f -y

RUN apt-get install -f -y

RUN export uid=1000 gid=1000 && \
    groupadd -f --gid ${gid} noodle && \
    adduser --disabled-password --uid ${uid} --gid ${gid} --shell /bin/bash --home /home/noodle --gecos noodle noodle && \
    echo "noodle ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/noodle && \
    chmod 0440 /etc/sudoers.d/noodle

#USER noodle
#ENV HOME /home/noodle
#ENV USER noodle
#ENV DISPLAY :0.0

VOLUME ["/tmp/.X11-unix"]

# Launch
#CMD sudo /etc/init.d/teamviewerd start && teamviewer
CMD sudo teamviewer --daemon start
