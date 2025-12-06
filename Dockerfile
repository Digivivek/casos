FROM php:8.2-apache

# Copy all project files
COPY . /var/www/html/

# Ensure tmp folder exists and is writable
RUN mkdir -p /var/www/html/tmp \
    && chmod -R 777 /var/www/html/tmp \
    && chown -R www-data:www-data /var/www/html/tmp

# Set PHP to use our tmp folder
RUN echo "upload_tmp_dir=/var/www/html/tmp" > /usr/local/etc/php/conf.d/tmp.ini \
    && echo "session.save_path=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini \
    && echo "sys_temp_dir=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini

# Enable Apache rewrite module (optional)
RUN a2enmod rewrite

EXPOSE 8080
