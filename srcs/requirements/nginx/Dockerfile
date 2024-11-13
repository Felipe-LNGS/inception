FROM debian:bullseye

RUN  apt update && apt upgrade -y

RUN apt install nginx -y

RUN apt install nano && apt insall vim && apt install curl -y 

RUN mkdir -p /etc/nginx/ssl && apt install OpenSSL -y

RUN    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=plangloi.42.fr/UID=plangloi"

COPY conf/nginx.conf /etc/nginx/nginx.conf



ENTRYPOINT [ "bash" ]