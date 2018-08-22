FROM debian:stretch
MAINTAINER Guenter Bailey

ENV DEBIAN_FRONTEND noninteractive
ENV MAILBACK="/home/.backend"

RUN apt-get update &&apt-get dist-upgrade -y && \
    apt-get install -y dovecot-core dovecot-pop3d dovecot-imapd sed \
    postfix sasl2-bin supervisor && rm -rf /var/lib/apt/lists/*

COPY ./config/10-master.conf /etc/dovecot/conf.d/
COPY ./config/main.cf /etc/postfix/
COPY ./entrypoint.sh /entrypoint.sh
COPY ./config/supervisord.conf /etc/supervisor/
COPY ./addmailuser.sh /addmailuser.sh

WORKDIR /
RUN sed -i "s/#listen =/listen =/g" /etc/dovecot/dovecot.conf && \
    sed -i "s/#disable_plaintext_auth = yes/disable_plaintext_auth = no/g" /etc/dovecot/conf.d/10-auth.conf && \
    sed -i "s/auth_mechanisms = plain/auth_mechanisms = plain login/g" /etc/dovecot/conf.d/10-auth.conf && \
    sed -i "s/mail_location = mbox:/#mail_location = mbox:/g" /etc/dovecot/conf.d/10-mail.conf && \
    echo "mail_location = maildir:~/Maildir" >> /etc/dovecot/conf.d/10-mail.conf && \
    echo "export MAIL=$HOME/Maildir" >> /etc/profile && \ 
    chmod a+x /entrypoint.sh /addmailuser.sh

#SMTP
EXPOSE 25/tcp
EXPOSE 465/tcp
EXPOSE 567/tcp
#IMAP
EXPOSE 110/tcp
EXPOSE 143/tcp

VOLUME ["/home"]

ENTRYPOINT ["/entrypoint.sh"]
