# Base image centos 7
FROM centos:7

# Maintained by
MAINTAINER Amal K Raj

# Environment varaibles
ENV MAGENTO_VERSION 2.3.5-p1
ENV SAMPLE_DATA sample_data
ENV MAGENTO_HOME /var/www/html/wipro-demo.com/public_html/magento
ENV PATH="${MAGENTO_HOME}/bin:${PATH}"

ENV MAGENTO_ADMIN_FIRSTNAME name
ENV MAGENTO_ADMIN_LASTNAME lname
ENV MAGENTO_ADMIN_EMAIL test@gmail.com
ENV MAGENTO_ADMIN_USER name
ENV MAGENTO_ADMIN_PASSWORD password
ENV MAGENTO_DB_NAME magento
ENV MAGENTO_DB_HOST mysql
ENV MAGENTO_DB_USER magento
ENV MAGENTO_DB_PASSWORD magento

# Installing dependancies
RUN yum update -y \
    && yum install -y wget vim net-tools cmake make gcc openssl-devel expat-devel deltarpm libxml2-devel \
       libpng libpng-devel libjpeg libjpeg-devel unzip

# Installing apacahe2
RUN yum install -y httpd

# Installing Php
COPY php.ini /etc/
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum -y install yum-utils \
    && yum-config-manager --enable remi-php72 \
    && yum update -y \
    && yum install -y php php-pdo php-mysqlnd php-opcache php-xml php-mcrypt php-gd \
       php-devel php-intl php-mbstring php-json php-iconv php-soap php-bcmath php-zip  

# Installing magento
COPY magento/magento-ce-${MAGENTO_VERSION}_${SAMPLE_DATA}-2020-04-24-10-19-21.zip /opt/

RUN mkdir -p $MAGENTO_HOME && mv /opt/*.zip $MAGENTO_HOME && cd $MAGENTO_HOME \
    && unzip *${MAGENTO_VERSION}*.zip

RUN cd $MAGENTO_HOME && ls -al

RUN mv magento-ce-${MAGENTO_VERSION}_${SAMPLE_DATA}-2020-04-24-10-19-21 magento \
    && rm *.zip

RUN cd $MAGENTO_HOME \
    && useradd magento \
    && usermod -g apache magento \
    && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; \
    && find var vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \; \
    && chown -R magento:apache . \
    && chmod u+x bin/magento

# Setting up the environment
WORKDIR /opt
COPY httpd.conf /etc/httpd/conf/
COPY magento-httpd.conf /etc/httpd/conf.d/
RUN mkdir /var/www/html/wipro-demo.com/logs
EXPOSE 80

# Adding startup script
COPY run.sh /opt/
RUN chmod +x /opt/run.sh

# Entrypoint
CMD ["apachectl", "-D", "FOREGROUND"]
