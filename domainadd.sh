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
CONF_FILE="/etc/httpd/conf.d/$DOMAIN.conf"

echo "Configuring...";

if [ -e $CONF_FILE ] # Controlling is conf file exits?
then
  cat > $CONF_FILE <<EOL
<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot /var/www/$DOMAIN
</VirtualHost>
EOL
fi

echo "Apache Service is reloading..."
systemctl reload httpd.service

echo "$DOMAIN added to your server."
