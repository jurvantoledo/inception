FROM debian:buster

EXPOSE 9000

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y php7.3-mysql php7.3-fpm mariadb-client curl

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/

# Create directory for PHP-FPM
RUN mkdir -p /run/php

# Configure PHP-FPM to listen on wordpress:9000
RUN sed -i "s/listen.*/listen = wordpress:9000/" /etc/php/7.3/fpm/pool.d/www.conf

# Copy script for WP and run script
COPY tools/configure.sh /var/www/
RUN chmod +x /var/www/configure.sh


# Set entrypoint. Use entrypoint when container starts
ENTRYPOINT ["/var/www/configure.sh"]

# Set command. This will be the argument of ENTRYPOINT
CMD ["php-fpm7.3", "-F"]