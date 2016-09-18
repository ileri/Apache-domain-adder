#!/bin/bash

clear

set -e

# Check current user status
if [ "$(id -u)" != 0 ]; then
  echo "This script must be run as root. 'sudo bash $0'"
  exit 1
fi

# Check Os type
os_type="$(lsb_release -si 2>/dev/null)"
if [ "$os_type" != "Ubuntu" ] && [ "$os_type" != "Debian" ]; then
  echo "Only supports Ubuntu/Debian"
  exit 1
fi

if [ ! -f /etc/redhat-release ]; then
  echo "Only supports Centos"
  exit 1
fi

# Check FQDN
echo "Enter FQDN(e.g. example.com or subdomain.example.com). www will be automatically aliased: "
read DOMAIN

FQDN_REGEX='^(([a-zA-Z](-?[a-zA-Z0-9])*)\.)*[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}$'
if ! printf %s "$DOMAIN" | grep -Eq "$FQDN_REGEX"; then
  echoerr "Invalid parameter. You must enter a FQDN domain name... (e.g. example.com or subdomain.example.com)"
  exit 1
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
