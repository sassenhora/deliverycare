FROM php:7.4-fpm

ENV APP_NAME deliverycare-api
ENV WORKDIR /var/www/app
ENV PATH $PATH:$WORKDIR/bin
ENV COMPOSER_CACHE_DIR $WORKDIR/cache/composer
ARG DEBUG
WORKDIR $WORKDIR

RUN apt-get update && \
    apt-get install -y \
        libpq-dev \
        zip \
        unzip \
        netcat && \
    apt-get clean && \
    docker-php-ext-install \
        pdo \
        pdo_pgsql && \
    curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chown www-data:www-data -R $WORKDIR

USER www-data

COPY --chown=www-data ./composer.json ./composer.lock ./
RUN composer install --no-scripts $(if ! $DEBUG ; then echo "--no-dev -a --prefer-dist"; fi) && \
    composer dump-autoload
COPY --chown=www-data ./ ./

ENTRYPOINT ["entrypoint"]
CMD ["php-fpm"]
