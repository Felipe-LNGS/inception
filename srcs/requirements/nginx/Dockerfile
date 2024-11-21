FROM debian:bullseye

# Mettre à jour et installer les paquets nécessaires
RUN apt update && apt upgrade -y && \
    apt install -y nginx vim curl openssl && \
    rm -rf /var/lib/apt/lists/*

# Générer le certificat SSL
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=plangloi.42.fr/UID=plangloi"

# Copier la configuration NGINX personnalisée
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Donner les bonnes permissions aux répertoires de travail
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Exposer le port 443 pour HTTPS
EXPOSE 443

# Lancer NGINX en mode non-démon
CMD ["nginx", "-g", "daemon off;"]
