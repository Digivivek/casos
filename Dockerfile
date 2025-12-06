FROM php:8.2-apache

# Copy code
COPY . /var/www/html/

# Writable tmp
RUN mkdir -p /var/www/html/tmp \
    && chown -R www-data:www-data /var/www/html/tmp \
    && chmod -R 777 /var/www/html/tmp

# PHP temp dirs
RUN echo "upload_tmp_dir=/var/www/html/tmp" > /usr/local/etc/php/conf.d/tmp.ini \
 && echo "session.save_path=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini \
 && echo "sys_temp_dir=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini

# Enable rewrite and allow .htaccess overrides
RUN a2enmod rewrite \
 && sed -i 's/AllowOverride None/AllowOverride All/i' /etc/apache2/apache2.conf

EXPOSE 8080
