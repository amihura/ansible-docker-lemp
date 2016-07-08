## WordPress+phpMyAdmin+Nginx+PHP-FPM(Apache)+proftpd ansible+docker

Docker Host Centos 7
Docker Images 6.x
Ansible v2.0.2.0

To run the playbook:
- Edit the `ansible/hosts` inventory file to include the names or URLs of the servers
you want to deploy.
- Set ENV parameter in `ansible/playbook.yml` to ```ENV=php-fpm``` or ```ENV=apache``` in depending
on stack which to use: lamp or lemp.
By default this value is set to ```ENV=php-fpm``` to use PHP-FPM.
- Set server_hostname in `ansible/playbook.yml`

Run the playbook using:

    ansible-playbook -i /ansible/hosts ansible/playbook.yml


You can deploy docker manually without ansible:
- Install docker on host VM
- Download repository with Dockerfiles
- Build images:
   1. MySQL: docker build -t="mysql-img" docker/mysql
   2. php-fpm: docker build -t="php-fpm-img" docker/php-fpm
   3. nginx: docker build -t="nginx-img" docker/nginx
   4. proftpd: docker build -t ="proftpd-img" docker/proftpd
- Run containers one by one:
   1. MySQL: docker run --name mysql mysql-img
   2. php-fpm: docker run -e ENV=php-fpm --link mysql --volumes-from mysql --name php-fpm php-fpm-img 
      You can use Apache instead of PHP-FPM just set it to: ENV=apache
   3. nginx: docker run -p 443:443 -p 80:80 -e ENV=php-fpm --link php-fpm --volumes-from php-fpm --name nginx nginx-img
      Here you also need to set proper ENV, it should match to ENV from poing 2.
   4. proftpd: docker run --net=host --volumes-from php-fpm --name proftpd proftpd-img
