#!/bin/bash

echo "updating the system";
apt update;
echo "upgrading the system";
apt upgrade;
echo "install dependcies";

source /etc/source-release

if [ $ID == "Debian" ]; then
  curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
elif [ $ID == "Ubuntu"]; then
  apt install software-properties-common -y && add-apt-repository ppa:ondrej/php

apt update;
apt install apache2 -y;
apt install php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-xsl php7.4-zip php7.4-bz2 libapache2-mod-php7.4 -y;
apt install mariadb-server mariadb-client -y;
mysql_secure_installation;
cd /usr/share;
apt install unzip wget
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip;
unzip phpmyadmin.zip;
rm phpmyadmin.zip;
mv phpMyAdmin-*-all-languages phpmyadmin;
chmod -R 0755 phpmyadmin;
wget -4 https://raw.githubusercontent.com/over-network/mariadbautomaticinstall/main/phpmyadmin.conf -P /etc/apache2/conf-available;
a2enconf phpmyadmin;
systemctl reload apache2;
mkdir /usr/share/phpmyadmin/tmp/;
chown -R www-data:www-data /usr/share/phpmyadmin/tmp/;
echo "please create a user. thx for using the script <3";
sleep 5
echo "---> Create User mysql -u root";
echo "CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';"
echo "GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;"
sleep 5
