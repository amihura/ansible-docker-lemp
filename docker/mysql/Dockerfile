FROM centos:centos6

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all


# Wordpress Requirements
RUN yum install -y mysql-server mysql MySQL-python cronie \
                   pwgen libselinux-python libsemanage-python

# Add mysql conf file
ADD ./my.cnf /etc/my.cnf

# mysql config
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/my.cnf

# Wordpress Initialization and Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN ./start.sh

# DB backup script
ADD ./db_backup.py /tmp/db_backup.py
RUN chmod 755 /tmp/db_backup.py

# private expose
EXPOSE 3306

# volume for mysql database and wordpress install
VOLUME ["/var/lib/mysql"]

CMD ["/usr/bin/mysqld_safe"]
