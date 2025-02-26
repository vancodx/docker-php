ARG PHP_VERSION=8.3
ARG COMPOSER_VERSION=2.8

ARG BUILD_SUFFIX=cli
ARG IMAGE_TAG=$PHP_VERSION-$BUILD_SUFFIX

FROM mlocati/php-extension-installer:2.7.0 AS php-extension-installer
FROM composer:$COMPOSER_VERSION AS composer
FROM php:$IMAGE_TAG

COPY --from=php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer /usr/bin/composer /usr/local/bin/

RUN apt-get update && apt-get install -y git

RUN install-php-extensions xdebug zip

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN echo 'xdebug.mode = coverage' >> "$PHP_INI_DIR/conf.d/docker-php.ini"

WORKDIR /usr/src/myapp

# COPY composer.json composer.lock ./
# RUN composer install --optimize-autoloader --no-interaction --no-scripts

COPY . .

CMD ["php", "-i"]
