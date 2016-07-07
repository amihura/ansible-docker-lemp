FROM centos:centos6

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all

# Basic Requirements
RUN yum install -y nginx httpd php-fpm mysql php-mysql php-apc pwgen curl git unzip phpmyadmin

# Wordpress Requirements
RUN yum install -y php-curl php-gd php-intl php-pear php-imap php-mcrypt php-pspell php-recode php-tidy php-xmlrpc php-xsl


# Adding configs
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.disabled
ADD ./wordpress.conf /etc/php-fpm.d/wordpress.conf


# Install Wordpress
RUN useradd wordpress -d /srv/wordpress
ADD https://wordpress.org/latest.tar.gz /srv/latest.tar.gz
RUN cd /srv && tar xvf latest.tar.gz && rm latest.tar.gz
RUN chown -R wordpress:wordpress /srv/wordpress


# proftpd presteps
RUN mkdir -p /srv/wordpress/wp-content/uploads
RUN groupadd -g 505 wp-user
RUN useradd -u 505 -g 505 wp-user -d /srv/wordpress/wp-content/uploads
RUN echo "secret" | passwd "wp-user" --stdin
RUN chown wordpress:wp-user -R /srv/wordpress/wp-content/uploads
RUN chmod 775 -R /srv/wordpress/wp-content/uploads

#Install PMA
RUN mv /usr/share/phpMyAdmin /srv/wordpress/phpmyadmin

# Wordpress Initialization and Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
#RUN /start.sh

#httpd confs
RUN rm -f /etc/httpd/conf.d/phpMyAdmin.conf
ADD ./httpd.conf /etc/httpd/conf.d/default.conf
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf

# private expose
EXPOSE 9000
EXPOSE 8080

# volume for mysql database and wordpress install
VOLUME ["/srv/wordpress"]

#CMD ["/usr/sbin/php-fpm"]

ENTRYPOINT /start.sh
