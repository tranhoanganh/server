#!/bin/bash

yum install epel-release -y

yum install wget -y
yum install zip -y
yum install unzip -y

yum install nginx -y

systemctl start nginx

systemctl enable nginx

sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

#install mariadb

wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup

chmod +x mariadb_repo_setup

sudo ./mariadb_repo_setup

yum install MariaDB-server -y

systemctl start mariadb.service

systemctl enable mariadb

wget https://raw.githubusercontent.com/tranhoanganh/server/main/my.cnf
yes | cp -rf my.cnf /etc

systemctl restart mariadb

# install php-fpm 7

yum install epel-release yum-utils -y

yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

yum-config-manager --enable remi-php74

yum install php-fpm php-common php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml -y

wget https://raw.githubusercontent.com/tranhoanganh/server/main/www.conf

yes | cp -rf www.conf /etc/php-fpm.d/

systemctl start php-fpm

systemctl enable php-fpm

wget https://raw.githubusercontent.com/tranhoanganh/server/main/nginx.conf
wget https://raw.githubusercontent.com/tranhoanganh/server/main/domain.com.conf
wget https://raw.githubusercontent.com/tranhoanganh/server/main/default.conf
wget https://raw.githubusercontent.com/tranhoanganh/server/main/php.conf
mkdir -p /etc/nginx/domains
yes | cp -rf domain.com.conf /etc/nginx/domains/
yes | cp -rf default.conf /etc/nginx/domains/
yes | cp -rf php.conf /etc/nginx/conf.d/
yes | cp -rf nginx.conf /etc/nginx

# Install phpMyAdmin

mkdir -p /var/www/html
chmod -R 755 /var/www/html
yum install phpmyadmin -y
ln -s /usr/share/phpMyAdmin /var/www/html/
cd /var/www/html
mv phpMyAdmin mydb

systemctl restart nginx
systemctl restart php-fpm
chown -R nginx:nginx /var/lib/php/session

# Install Java Spring

yum install java-1.8.0-openjdk -y



