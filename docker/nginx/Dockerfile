FROM centos:centos6

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all

# Basic Requirements
RUN yum install -y install nginx php-fpm php-mysql php-apc pwgen python-setuptools curl git unzip

# Wordpress Requirements
RUN yum install -y install php-curl php-gd php-intl php-pear php-imagick php-imap php-mcrypt php5-memcache php5-ming php-ps php-pspell php-recode php5-sqlite php-tidy php-xmlrpc php-xsl pyton-setuptool openssl

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/certs
RUN openssl req -new -nodes -x509 -subj "/C=BY/ST=Minsk/L=Minsk/O=IT/CN=localhost" -days 3650 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt -extensions v3_ca

#ADD ./default.conf /etc/nginx/conf.d/default.conf
ADD ./php-fpm.conf /tmp
ADD ./httpd.conf /tmp
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 80
EXPOSE 443

#CMD ["/usr/sbin/nginx"]
ENTRYPOINT /start.sh
