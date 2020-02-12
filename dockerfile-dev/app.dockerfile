# See: https://github.com/mrfoh/docker-laravel
FROM php:7.2-fpm

RUN apt-get update && \
  apt-get install -y postgresql-server-dev-all libmcrypt-dev git zlib1g-dev zip unzip libmemcached-dev git \
  && pecl install mcrypt-1.0.1  \
  && docker-php-ext-enable mcrypt  \
  && docker-php-ext-install pdo_pgsql  \
  && docker-php-ext-install zip 
RUN apt-get install -y build-essential libpng-dev libjpeg-dev libfreetype6-dev

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
