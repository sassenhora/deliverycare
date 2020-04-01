FROM php:7.4.0-cli

ENV WORKDIR /var/www/app
ENV PATH $PATH:$WORKDIR/bin
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
    curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./composer* ./
RUN composer install
COPY ./ ./

ENTRYPOINT ["entrypoint"]
CMD ["tail", "-f", "/dev/null"]
