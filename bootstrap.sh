#!/usr/bin/env bash

apt-get update
apt-get -y install apache2

mkdir /vagrant/web
rm -rf /var/www/html
ln -fs /vagrant/web /var/www/html

cd /var/www/html

# enable modrewrite
a2enmod rewrite 

echo "
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html
  ServerName $1
  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
  <Directory /var/www/html>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
  </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/vagrant.conf

echo "ServerName localhost" >> /etc/apache2/apache2.conf 

echo "export APACHE_RUN_USER=vagrant >> /etc/apache2/envvars"

a2ensite vagrant.conf

locale-gen en_US en_US.UTF-8 pl_PL pl_PL.UTF-8
dpkg-reconfigure locales

export DEBIAN_FRONTEND=noninteractive

# Install MySql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
apt-get -q -y install mysql-server-5.6 mysql-client-5.6
echo "CREATE DATABASE magento" | mysql -uroot -pvagrant


apt-get -q -y install python-software-properties

add-apt-repository ppa:ondrej/php
apt-get -q -y update
apt-get -q -y purge php5-fpm
apt-get -q -y install php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0 php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-mysql php7.0-bz2 php7.0-dev

/etc/init.d/apache2 restart

apt-get -q -y install php7.0-xml
apt-get -q -y install php7.0-mcrypt
apt-get -q -y install php7.0-intl
apt-get -q -y install php7.0-mbstring
apt-get -q -y install php7.0-zip
apt-get -q -y install php7.0-bcmath
apt-get -q -y install php-pear
apt-get -q -y install libcurl3-openssl-dev
pecl install pecl_http
/etc/init.d/apache2 restart

echo "date.timezone = America/Chicago" >> /etc/php/7.0/cli/php.ini
pear config-set php_ini /etc/php/7.0/apache2/php.ini

pecl install xdebug
echo "xdebug.remote_enable = 1" >> /etc/php/7.0/apache2/php.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/apache2/php.ini

apt-get -y install git
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

service apache2 restart

