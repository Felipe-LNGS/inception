FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install nginx -y

RUN apt insall vim -y

RUN apt install curl -y 

RUN mkdir -p /etc/nginx/ssl 

# RUN apt install OpenSSL -y

# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=plangloi.42.fr/UID=plangloi"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "bash" ]