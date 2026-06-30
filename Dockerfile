FROM php:8.2-apache

# libcurl ইনস্টল করুন (curl এক্সটেনশনের জন্য দরকার)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    && docker-php-ext-install curl

# Apache-এর DocumentRoot 'api' ফোল্ডারে সেট করুন
ENV APACHE_DOCUMENT_ROOT /var/www/html/api
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# আপনার PHP ফাইল কপি করুন
COPY ./api /var/www/html/api
