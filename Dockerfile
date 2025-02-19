ARG PHP_VERSION=8.3
ARG COMPOSER_VERSION=2.8

ARG BUILD_SUFFIX=cli
ARG IMAGE_TAG=$PHP_VERSION-$BUILD_SUFFIX

FROM composer:$COMPOSER_VERSION AS composer
FROM php:$IMAGE_TAG

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer /usr/bin/composer /usr/local/bin/

# COPY . /usr/src/myapp
# WORKDIR /usr/src/myapp

CMD ["php", "-i"]
