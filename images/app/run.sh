#!/bin/bash

magento setup:install --admin-firstname=$MAGENTO_ADMIN_FIRSTNAME \
      --admin-lastname=$MAGENTO_ADMIN_LASTNAME --admin-email=$MAGENTO_ADMIN_EMAIL \
      --admin-user=$MAGENTO_ADMIN_USER --admin-password=$MAGENTO_ADMIN_PASSWORD \
      --db-name=$MAGENTO_DB_NAME --db-host=$MAGENTO_DB_HOST --db-user=$MAGENTO_DB_USER \
      --db-password=$MAGENTO_DB_PASSWORD

magento setup:di:compile

apachectl -D FOREGROUND