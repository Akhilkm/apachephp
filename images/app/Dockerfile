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
ENV PHP_VERSION 7.2.31
ENV PHP_HOME /opt/php
ENV PATH="/opt/apache2/bin:${MAGENTO_HOME}/bin:${PHP_HOME}/bin:${PATH}"

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
    && yum install -y wget vim net-tools cmake make gcc openssl-devel expat-devel deltarpm libxml2-devel libtool libpng-devel

# Installing apacahe2
RUN cd /opt \
    && useradd apache \
    && wget https://archive.apache.org/dist/httpd/httpd-$APACHE_VERION.tar.gz \
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
    && ./configure --prefix=/opt/apache2 --with-included-apr --enable-so \
    && make \
    && make install \
    && cd /opt/ \
    && rm -rf /opt/httpd-2.4.43* \
    && chown -R apache:apache /opt/apache2 

# Installing Php
COPY php.ini /opt/php/lib/php.ini
RUN cd /opt \
    && yum install -y curl curl-devel libicu-devel gcc-c++ libxslt libxslt-devel \
    && wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz \
    && tar -zxvf php-${PHP_VERSION}.tar.gz \
    && cd php-${PHP_VERSION} \
    && ./configure --prefix=$PHP_HOME --with-apxs2=${APACHE_HOME}/bin/apxs --with-mysqli=mysqlnd \
                   --with-pdo-mysql=mysqlnd --with-openssl --enable-zip --enable-intl  --enable-mbstring  \
                   --enable-bcmath --enable-soap --enable-sockets --with-curl --with-xsl --enable-opcache \
                   --enable-xml --with-iconv --with-gd \
    && make \
    && make install \
    && libtool --finish /opt/php-7.2.31/libs \
    && ln -s $PHP_HOME/lib/php.ini $PHP_HOME/etc/ \
    && chmod 755 ${APACHE_HOME}/modules/libphp7.so \
    && rm -rf /opt/php-* 

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

# Adding startup script
COPY run.sh /opt/
RUN chmod +x /opt/run.sh

# Entrypoint
CMD ["apachectl", "-D", "FOREGROUND"]