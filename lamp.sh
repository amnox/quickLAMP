if [ -z "$1" ]; then
  echo "Error: No arguements given, for help run:"
  echo "./lamp.sh help"
fi
#APACHE

if [ "$1" == "apache" ]; then
  if [ -z "$2" ]; then
    echo "Error: Pass IP or domain in args"
  else
    sudo apt-get update
    sudo apt-get install apache2
    sudo apache2ctl configtest
    #Change server_domain_or_IP and uncomment below line
    #sudo sed -e "\$aServerName $2" /etc/apache2/apache2.conf >> /etc/apache2/apache2.conf
    sudo ufw app info "Apache Full"
    sudo apache2ctl configtest
    sudo systemctl restart apache2
  fi
fi

#mysql

if [ "$1" == "mysql" ]; then
  echo "MYSQL INSTALLATION"
  sudo apt-get install php-mysql
  sudo apt-get install mysql-server
  sudo apt-get install php libapache2-mod-php php-mcrypt

fi


#PHP

if [ "$1" == "php" ]; then
  sudo rm /etc/apache2/mods-enabled/dir.conf
  printf "<IfModule mod_dir.c>\n    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>\n" >> /etc/apache2/mods-enabled/dir.conf
  systemctl  status apache2.service
  sudo systemctl restart apache2
  sudo apt-get install curl php-cli
fi

if [ "$1" == "help" ]; then

  echo "To install Apache run: "
  echo "./lamp.sh apache {your IP or domain name}"
  echo "To install Mysql run: "
  echo "./lamp.sh mysql"
  echo "To install PHP run: "
  echo "./lamp.sh php"
fi
