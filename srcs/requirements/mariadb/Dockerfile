FROM debian:buster

EXPOSE 3306

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

# Copy configure.sh script to /usr/bin/ and make it executable
COPY tools/configure.sh /usr/bin/
RUN chmod +x /usr/bin/configure.sh

# Create /var/run/mysqld directory and set ownership to mysql:root
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:root /var/run/mysqld

# set bind-address in MariaDB config file to "mariadb"
RUN sed -i "s/bind-address.*/bind-address = mariadb/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Set entrypoint. Use entrypoint when container starts
ENTRYPOINT ["configure.sh"]

# Set command. This will be the argument of ENTRYPOINT
CMD ["mysqld"]
