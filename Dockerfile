#FROM goodrain.me/debian:wheezy_42101
FROM debian:wheezy

MAINTAINER ethan@goodrain.com

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.4-1~wheezy

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION}  nano pwgen unzip wget && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/nginx/*.d
ADD etc /etc
RUN mkdir -pv /data/http /data/logs/nginx /data/config

ADD index.html /data/http/

EXPOSE 5000

CMD ["nginx"]