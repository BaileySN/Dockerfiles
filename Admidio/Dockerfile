############################################
# Dockerfile to build Nginx Server with PHP
# Based on Debian Jessie Image
############################################
FROM debian:jessie
MAINTAINER Guenter Bailey
# install required packages
RUN apt-get update
RUN apt-get install -y nginx php5 php5-fpm php-pear php5-common php5-mcrypt php5-mysql php5-cli php5-gd zip unzip tar gzip php5-pgsql gettext-base
# set enviroments

ENV NGINXCONF="/etc/nginx/conf.d"
ENV WWW="/var/www/html"
ENV ADMINST="admidio-3.2.8"
ENV ADM="admidio"

COPY nginx_default.conf $NGINXCONF/"site.conf"
COPY $ADMINST.zip $WWW/

WORKDIR $WWW
RUN rm "index.nginx-debian.html"
RUN unzip $ADMINST.zip && mv $ADMINST $ADM && chown -R www-data:www-data $ADM && chmod 777 $ADM/adm_my_files

VOLUME ["$WWW/$ADM/adm_my_files", "$NGINXCONF"]

# Port to expose
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
