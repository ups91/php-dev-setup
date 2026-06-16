FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    wget \
    nano \
    vim \
    libicu-dev \
    libzip-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt1-dev \
    libpq-dev \
    libsqlite3-dev \
    libldap2-dev \
    libmagickwand-dev \
    libgmp-dev \
    libbz2-dev \
    libtidy-dev \
    libsodium-dev

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    ftp \
    gd \
    gettext \
    gmp \
    intl \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    sodium \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    xsl \
    zip

RUN docker-php-ext-configure ldap \
    --with-libdir=lib/x86_64-linux-gnu \
 && docker-php-ext-install ldap

RUN pecl install xdebug redis mongodb imagick

RUN docker-php-ext-enable \
    xdebug \
    redis \
    mongodb \
    imagick

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN { \
    echo "xdebug.mode=debug,develop"; \
    echo "xdebug.start_with_request=yes"; \
    #echo "xdebug.discover_client_host=1"; \
    echo "xdebug.client_host=host.docker.internal"; \
    echo "xdebug.client_port=9003"; \
    echo "xdebug.log=/tmp/xdebug.log"; \
    echo "xdebug.log_level=10"; \
} > /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/html
