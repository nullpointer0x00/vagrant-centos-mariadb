# vagrant-centos-mariadb

Vagrant configuration to create a CentOS 7.1 with Mariadb 10.1.

##Dependencies

1. VitualBox https://www.virtualbox.org/wiki/Downloads
2. Vagrant https://www.vagrantup.com/docs/installation

##Commands to get started

These commands need to be run within the vagrant folder that contains the files of this project.

1. `vagrant up` to start the vm instance.  If this is the first time, it will run the install.sh file and configure the machine.
2. `vagrant halt` or `vagrant shutdown` will shutdown the vm.  To start it again, use `vagrant up`.
3. `vagrant destroy` will shutdown and delete all resouces of the vm.
4. `vagrant ssh` will ssh into the vm.

Documentation: https://www.vagrantup.com/docs/cli/

##Mariadb Configuration

The install.sh script installs and configures the database with default login values.

1. User: root Password: password
2. User: someuser Password: password

I recommend changing the install.sh to create a username and password that is relevant to the project. By changing this line in the install script.

`mysql -u root -ppassword -e "CREATE USER 'someuser'@'%' IDENTIFIED BY 'password';GRANT ALL ON *.* TO 'someuser'@'%';FLUSH PRIVILEGES;"`
