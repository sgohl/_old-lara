FROM php:8

ENV COMPOSER_MEMORY_LIMIT=-1

RUN apt-get update && apt-get -y install libldap2-dev git-core

RUN docker-php-ext-install pdo_mysql ldap

RUN curl -Ls https://getcomposer.org/installer | php \
&&  chmod +x composer.phar \
&&  mv composer.phar /usr/local/bin/composer
