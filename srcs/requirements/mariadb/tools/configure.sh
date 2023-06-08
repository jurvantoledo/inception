#!/bin/bash

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	echo "setting up mariadb"

	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	{
		echo "FLUSH PRIVILEGES;"
		# Create database
		echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

		# Create user
		echo "CREATE USER IF NOT EXISTS $MYSQL_USERNAME@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
		echo "GRANT ALL PRIVILEGES ON *.* TO $MYSQL_USERNAME@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

		# Making sure permissions are applied
		echo "FLUSH PRIVILEGES;"
	} | mysqld --bootstrap
else
	echo "mariadb already configured"
fi

exec "$@"