#!/bin/bash
if [ "$EUID" -ne 0 ] # If not root
  then
    echo "Please run as root!";
    exit;
fi
if [ -z ${1+x} ] # Argument control
then
  echo -n "Enter FQDN(e.g. example.com or subdomain.example.com). www will be automatically aliased: ";
  read DOMAIN;
else
  DOMAIN=$1
fi

echo "Creating directory...";
mkdir /var/www/$DOMAIN;
echo "Configuring...";

if [ -e "/etc/httpd" ]
then
  CONF_FILE="/etc/httpd/conf.d/$DOMAIN.conf"
elif [ -e "/etc/apache2" ]
then
  CONF_FILE="/etc/apache2/sites-available/$DOMAIN.conf"
else
  echo "Couldn't find Apache2 configurate directory. Exiting..."
  exit
fi

if [ -e $CONF_FILE ] # Controlling is conf file exits?
then
  echo "There is already a $CONF_FILE exists."
  echo -n "Do you want to overwrite it? (y/N): "
  read ANSWER
  if [[ ( "$ANSWER" != "y" ) && ( "$ANSWER" != "Y" ) && ( "$ANSWER" != "yes" )
   && ( "$ANSWER" != "Yes" ) && ( "$ANSWER" != "YES" )]]
  then
    echo "Aborting..."
    exit
  fi
fi

cat > $CONF_FILE <<EOL
<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot /var/www/$DOMAIN
</VirtualHost>
EOL

echo "Apache Service is reloading..."
systemctl reload httpd.service

echo "$DOMAIN added to your server."
