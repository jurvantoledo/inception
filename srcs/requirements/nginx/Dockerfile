FROM debian:buster

EXPOSE 443

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/sites-available/nginx.conf

# Remove sites-enabled
RUN rm -rf /etc/nginx/sites-enabled/*
# Create soft link with back-up
RUN ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Copy configure.sh script to /usr/bin/ and make it executable
COPY tools/configure.sh /usr/bin/
RUN chmod +x /usr/bin/configure.sh

# Creating the SSL certificate
RUN openssl req -new \
	-newkey rsa:2048 \
	-x509 \
	-sha256 \
	-days 3560 \
	-nodes \
	-out /etc/ssl/certs/certificate.crt \
	-keyout /etc/ssl/private/certificate.key \
	-subj "/C=$SSL_COUNTRY/ST=$SSL_STATE/L=$SSL_CITY/O=$SSL_ORGANISATION/CN=$DOMAIN_NAME"

# Set entrypoint. Use entrypoint when container starts
ENTRYPOINT ["configure.sh"]

# Set command. This will be the argument of ENTRYPOINT
CMD ["nginx", "-g", "daemon off;"]