#!/bin/bash

if [ $ENV = "php-fpm" ]; then
   cp /tmp/php-fpm.conf /etc/nginx/conf.d/default.conf
elif [ $ENV = "apache" ]; then
   cp /tmp/httpd.conf /etc/nginx/conf.d/default.conf
fi

exec /usr/sbin/nginx
