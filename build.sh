#!/bin/bash

# Project related environment variables
export PROJECT_NAME=magento

# Mysql related environment variables
export MYSQL_ROOT_PASSWORD=admin
export MYSQL_DATABASE=wipro
export MYSQL_USER=admin
export MYSQL_PASSWORD=Wipro@123

# Magento related environment variables
export MAGENTO_BASE_URL=http://wipro-demo.com/magento/
export MAGENTO_BACKEND_FRONTNAME=admin
export MAGENTO_LANGUAGE=en_US
export MAGENTO_CURRENCY=USD
export MAGENTO_TIMEZONE=America/Chicago
export MAGENTO_USE_REWRITE=1
export MAGENTO_ADMIN_FIRSTNAME=Amal
export MAGENTO_ADMIN_LASTNAME=Raj
export MAGENTO_ADMIN_EMAIL=amal.raj2@wipro.com
export MAGENTO_ADMIN_USER=admin
export MAGENTO_ADMIN_PASSWORD=Wipro@123
export MAGENTO_DB_HOST=mysql
export MAGENTO_DB_NAME=$MYSQL_DATABASE
export MAGENTO_DB_USER=$MYSQL_USER
export MAGENTO_DB_PASSWORD=$MYSQL_PASSWORD

# System related environment variables
export MYSQL_PORT=3306
export MYSQL_VOLUME_PATH=/opt/$PROJECT_NAME-mysql
export APACHE_PORt=30000


envsubst < docker-compose.yml | cat -

