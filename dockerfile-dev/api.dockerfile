# See: https://github.com/mrfoh/docker-laravel
FROM php:7.2-fpm

RUN apt-get update && \
  apt-get install -y postgresql-server-dev-all libmcrypt-dev git zlib1g-dev zip unzip libmemcached-dev git \
  && pecl install mcrypt-1.0.1  \
  && docker-php-ext-enable mcrypt  \
  && docker-php-ext-install pdo_pgsql  \
  && docker-php-ext-install zip 

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN docker-php-source extract \
    && git clone --branch php7 https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached/ \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && docker-php-source delete \
    && rm -rf /tmp/* /var/cache/apk/*