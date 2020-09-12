FROM php:7.4-fpm-alpine

SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

# composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

ARG TZ

RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies \
    autoconf=~2.69 \
    gcc \
    g++ \
    make=~4.2 \
    git=~2.24 && \
  apk add --update --no-cache oniguruma-dev=~6.9 \
    libzip-dev \
    tzdata && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  echo ${TZ} > /etc/timezone && \
  pecl install xdebug && \
  apk del .build-dependencies tzdata && \
  docker-php-ext-install pdo_mysql mysqli mbstring zip && \
  docker-php-ext-enable xdebug && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
  composer global require hirak/prestissimo && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.jp
