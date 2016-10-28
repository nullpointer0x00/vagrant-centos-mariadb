#!/usr/bin/bash

echo "Adding new mariadb repo to upgrade mariadb from v5.5 to v10"
sudo cp /vagrant/MariaDB.repo /etc/yum.repos.d/.

echo "Installing mariadb with yum..."
sudo yum -y update
sudo yum -y install MariaDB-server MariaDB-client
sudo systemctl stop mariadb
systemctl start mariadb

echo "Enable mariadb service to start at boot..."
sudo systemctl enable mariadb.service
echo "Configuring root user with password: password..."
sudo /usr/bin/mysqladmin -u root password 'password'

echo "Granting privileges to root, drop test database, dropping anon users, creating no root user..."
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -u root -ppassword -e "DROP DATABASE test;"
mysql -u root -ppassword -e "DROP USER ''@'localhost';"
mysql -u root -ppassword -e "DROP USER ''@'$(hostname)';"
mysql -u root -ppassword -e "CREATE USER 'someuser'@'%' IDENTIFIED BY 'password';GRANT ALL ON *.* TO 'someuser'@'%';FLUSH PRIVILEGES;"

echo "Restarting mariadb"
sudo systemctl stop mariadb
sudo systemctl start mariadb
