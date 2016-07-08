FROM centos:centos6

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install proftpd


RUN groupadd -g 500 wordpress
RUN useradd -u 500 -g 500 wordpress -d /srv/wordpress


RUN mkdir -p /srv/wordpress/wp-content/uploads
RUN groupadd -g 505 wp-user
RUN useradd -u 505 -g 505 wp-user -d /srv/wordpress/wp-content/uploads
RUN echo "secret" | passwd "wp-user" --stdin
RUN chown wordpress:wp-user -R /srv/wordpress/wp-content/uploads
RUN chmod 775 -R /srv/wordpress/wp-content/uploads
ADD ./proftpd.conf /etc/proftpd.conf

EXPOSE 20
EXPOSE 21

CMD ["/usr/sbin/proftpd", "--nodaemon"]
