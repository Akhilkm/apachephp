#!/bin/bash

sleep 10

magento setup:install --base-url=$MAGENTO_BASE_URL --backend-frontname=$MAGENTO_BACKEND_FRONTNAME \
      --language=$MAGENTO_LANGUAGE --currency=$MAGENTO_CURRENCY --timezone=$MAGENTO_TIMEZONE \
      --use-rewrites=$MAGENTO_USE_REWRITE --admin-firstname=$MAGENTO_ADMIN_FIRSTNAME \
      --admin-lastname=$MAGENTO_ADMIN_LASTNAME --admin-email=$MAGENTO_ADMIN_EMAIL \
      --admin-user=$MAGENTO_ADMIN_USER --admin-password=$MAGENTO_ADMIN_PASSWORD \
      --db-name=$MAGENTO_DB_NAME --db-host=$MAGENTO_DB_HOST --db-user=$MAGENTO_DB_USER \
      --db-password=$MAGENTO_DB_PASSWORD

magento setup:di:compile

apachectl -D FOREGROUND