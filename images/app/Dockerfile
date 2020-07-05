# Base image centos 7
FROM centos:7

# Maintained by
MAINTAINER Amal K Raj

# Environment varaibles
ENV APACHE_VERION 2.4.43
ENV APACHE_HOME /opt/apache2
ENV PATH="/opt/apache2/bin:/opt/magento/bin:${PATH}"
ENV MAGENTO_VERSION 2.3.4
ENV SAMPLE_DATA sample_data
ENV MAGENTO_HOME /opt/magento

# Installing dependancies
RUN yum update -y \
    && yum install -y wget vim net-tools cmake make gcc openssl-devel expat-devel deltarpm 

# Installing Php

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum -y install yum-utils \
    && yum-config-manager --enable remi-php72 \
    && yum update -y \
    && yum install -y php php-pdo php-mysqlnd php-opcache php-xml php-mcrypt php-gd php-devel php-intl php-mbstring php-json php-iconv

COPY php.ini /etc/php.ini

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

# Installing magento
COPY magento/magento-ce-${MAGENTO_VERSION}-p2_${SAMPLE_DATA}-2020-04-25-01-31-19.tar.gz /opt/
RUN mkdir $MAGENTO_HOME && mv /opt/*.tar.gz $MAGENTO_HOME && cd $MAGENTO_HOME \
    && tar -zxvf *${MAGENTO_VERSION}*.tar.gz \
    && rm $MAGENTO_HOME/*${MAGENTO_VERSION}*.tar.gz

# Passing control to apache user
USER apache

# Setting up the environment
WORKDIR /opt/apache2
COPY httpd.conf conf/httpd.conf
EXPOSE 8080

# Entrypoint
CMD ["apachectl", "-D", "FOREGROUND"]
