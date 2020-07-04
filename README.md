## Basic LAMP web application
Apache php project

### Starting the service
```
docker-compose  -p magento up -d
```

### Login into the app container
```
docker exec -it magento_apachephp_1 /bin/bash
```

### Check db connection
```
docker cp sample/checkmysql.php magento_apachephp_1:/tmp/
docker exec magento_apachephp_1 php /tmp/checkmysql.php
```

### Cleanup
```
docker-compose -p magento down
```
