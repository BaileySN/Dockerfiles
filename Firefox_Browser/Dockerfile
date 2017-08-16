FROM debian:jessie

# added contrib and non-free
RUN printf 'deb http://deb.debian.org/debian jessie main contrib non-free \ndeb http://deb.debian.org/debian jessie-updates main contrib non-free \ndeb http://security.debian.org jessie/updates main contrib non-free' >/etc/apt/sources.list

RUN apt-get update && apt-get install -y firefox-esr sudo flashplugin-nonfree

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
CMD /usr/bin/firefox-esr
