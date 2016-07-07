#!/bin/bash

  #mysql has to be started this way as it doesn't work to call from /etc/init.d
  /usr/bin/mysql_install_db
  sleep 3
  cd /usr ; /usr/bin/mysqld_safe &
  sleep 10s
  # Generate random passwords. The first two are for mysql users
  MYSQL_PASSWORD="secret"
  #This is so the passwords show up in logs.
  echo mysql root password: $MYSQL_PASSWORD
  echo $MYSQL_PASSWORD > /mysql-root-pw.txt

# creating db, users
  mysqladmin -u root password $MYSQL_PASSWORD
  mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"
  killall mysqld

echo "#Ansible: Backup mysql tables" > /etc/cron.d/db_backup 
echo "0 4 * * * root /tmp/db_backup.py" >> /etc/cron.d/db_backup
service crond start
