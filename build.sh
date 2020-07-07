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

function change_baseurl() {
    grep -rl "wipro-demo.com" * -R | xargs sed -i "s|wipro-demo.com|${MAGENTO_BASE_URL}|g"
}

function build_image() {
    envsubst < docker-compose.yml | docker-compose -p $PROJECT_NAME build -f -
}

function start_service() {
    envsubst < docker-compose.yml | docker-compose -p $PROJECT_NAME up -d -f -
}

function down_service() {
    envsubst < docker-compose.yml | docker-compose -p $PROJECT_NAME down -f -
}

export Command_Usage="Usage: ./build.sh -o [OPTION...]"

while getopts ":o:" opt
   do
     case $opt in
        o ) option=$OPTARG;;
     esac
done

if [[ $option = url-replace ]]; then
    echo "Changing the base url"
    change_baseurl
elif [[ $option = build ]]; then
    build_image
elif [[ $option = deploy ]]; then
    start_service
elif [[ $option = down ]]; then
    down_service
else
	echo "$Command_Usage"
cat << EOF
_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
Main modes of operation:
build             :   Building the images
deploy            :   Deploying the application into server
url-replace       :   For replacing the base url
down              :   Cleanup the resources
_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
EOF
fi