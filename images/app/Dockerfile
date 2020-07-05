# Base image centos 7
FROM centos:7

# Maintained by
MAINTAINER Amal K Raj

# Environment varaibles
ENV APACHE_VERION 2.4.43
ENV APACHE_HOME /opt/apache2
ENV MAGENTO_VERSION 2.3.4
ENV SAMPLE_DATA sample_data
ENV MAGENTO_HOME /opt/apache2/htdocs/magento2
ENV PATH="/opt/apache2/bin:${MAGENTO_HOME}/bin:${PATH}"

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
    && yum install -y wget vim net-tools cmake make gcc openssl-devel expat-devel deltarpm 

# Installing apacahe2
RUN cd /opt \
    && wget https://mirrors.estointernet.in/apache//httpd/httpd-$APACHE_VERION.tar.gz \
    && tar -zxvf httpd-${APACHE_VERION}.tar.gz \
    && cd httpd-${APACHE_VERION} \
    && cd srclib \
    && wget https://mirrors.estointernet.in/apache//apr/apr-1.7.0.tar.gz \
    && wget https://mirrors.estointernet.in/apache//apr/apr-util-1.6.1.tar.gz \
    && tar -zxvf apr-1.7.0.tar.gz \
    && tar -zxvf apr-util-1.6.1.tar.gz \
    && rm -rf  *.tar.gz \
    && mv apr-1.7.0 apr \
    && mv apr-util-1.6.1 apr-util \
    && cd .. \
    && ./configure --prefix=/opt/apache2 --with-included-apr \
    && make \
    && make install \
    && cd /opt/ \
    && rm -rf /opt/httpd-2.4.43* \
    && chown -R apache:apache /opt/apache2 

# Installing Php

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum -y install yum-utils \
    && yum-config-manager --enable remi-php72 \
    && yum update -y \
    && yum install -y php php-pdo php-mysqlnd php-opcache php-xml php-mcrypt php-gd \
       php-devel php-intl php-mbstring php-json php-iconv php-soap php-bcmath php-zip  

COPY php.ini /etc/php.ini

# Installing magento
COPY magento/magento-ce-${MAGENTO_VERSION}-p2_${SAMPLE_DATA}-2020-04-25-01-31-19.tar.gz /opt/

RUN mkdir $MAGENTO_HOME && mv /opt/*.tar.gz $MAGENTO_HOME && cd $MAGENTO_HOME \
    && tar -zxvf *${MAGENTO_VERSION}*.tar.gz  \
    && rm *.tar.gz

RUN cd $MAGENTO_HOME \
    && useradd magento \
    && usermod -g apache magento \
    && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; \
    && find var vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \; \
    && chown -R magento:apache . \
    && chmod u+x bin/magento

# Setting up the environment
WORKDIR /opt/apache2
COPY httpd.conf conf/httpd.conf
EXPOSE 8080

# Adding startup script
COPY run.sh /opt/
RUN chmod +x /opt/run.sh

# Entrypoint
CMD ["apachectl", "-D", "FOREGROUND"]
