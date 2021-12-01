FROM php:8

ENV COMPOSER_MEMORY_LIMIT=-1

RUN docker-php-ext-install pdo_mysql
