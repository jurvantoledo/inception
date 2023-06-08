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

# Set entrypoint. Use entrypoint when container starts
ENTRYPOINT ["configure.sh"]

# Set command. This will be the argument of ENTRYPOINT
CMD ["nginx", "-g", "daemon off;"]