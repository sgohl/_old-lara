FROM php:8-alpine

ENV COMPOSER_MEMORY_LIMIT=-1
#ENV COMPOSER_ALLOW_SUPERUSER 1
ENV GIT_SSL_NO_VERIFY 1

RUN apk update ; apk upgrade \
&&  apk add -U --no-cache jq git bash composer icu-dev jpeg-dev libpng-dev libxpm-dev freetype-dev libxml2-dev curl-dev  libedit-dev libzip-dev zlib-dev libmemcached-dev libxslt-dev pcre-dev openldap-dev libldap zstd-dev

RUN apk add -U --no-cache autoconf gcc g++ libtool make imagemagick6-dev 
RUN yes | pecl install xdebug && docker-php-ext-enable xdebug
RUN yes | pecl install imagick && docker-php-ext-enable imagick
RUN yes | pecl install -o -f igbinary && docker-php-ext-enable igbinary 
RUN yes | pecl install -o -f redis && docker-php-ext-enable redis

RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-xpm=/usr/include 
RUN docker-php-ext-install gd intl  xml zip curl opcache ldap soap pdo_mysql mysqli bcmath exif pcntl

# tokenizer

RUN apk del autoconf gcc g++ libtool make && rm -rf /tmp/pear
