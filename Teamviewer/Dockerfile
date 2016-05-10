FROM     ubuntu:14.04

RUN dpkg --add-architecture i386 && \
    apt-get -q update && \
    apt-get -q upgrade -y && \
    apt-get -q install -y adduser libasound2:i386 libc6:i386 libfreetype6:i386 \
        libgcc1:i386 libsm6:i386 libxdamage1:i386 libxext6:i386 \
        libxfixes3:i386 libxrandr2:i386 libxrender1:i386 libxtst6:i386 sudo \
        wget zlib1g:i386 libjpeg8:i386 libexpat1:i386 fonts-liberation:i386 \
        libfontconfig1:i386 fontconfig-config:i386 ucf \
        libdbus-1-3:i386 libjpeg62:i386 libxinerama1:i386 libnet-ifconfig-wrapper-perl\
        libpng12-0:i386 procps htop nano


RUN wget http://download.teamviewer.com/download/teamviewer_i386.deb -O /tmp/teamviewer_linux.deb && \
    dpkg -i /tmp/teamviewer_linux.deb

RUN apt-get install -f -y

RUN adduser --disabled-password --gecos noodle noodle && \
    echo "noodle	ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/noodle


USER noodle
ENV USER noodle
ENV DISPLAY :0.0

# Launch
CMD sudo /etc/init.d/teamviewerd start && teamviewer
