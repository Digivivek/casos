FROM php:8.2-apache

# Copy code
COPY . /var/www/html/

# Writable tmp for the loader
RUN mkdir -p /var/www/html/tmp \
    && chown -R www-data:www-data /var/www/html/tmp \
    && chmod -R 777 /var/www/html/tmp

# PHP should use our tmp
RUN echo "upload_tmp_dir=/var/www/html/tmp" > /usr/local/etc/php/conf.d/tmp.ini \
 && echo "session.save_path=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini \
 && echo "sys_temp_dir=/var/www/html/tmp" >> /usr/local/etc/php/conf.d/tmp.ini

# Enable rewrite and allow .htaccess to work
RUN a2enmod rewrite \
 && sed -i 's/AllowOverride None/AllowOverride All/i' /etc/apache2/apache2.conf

# If your app forces HTTPS, tell PHP it's behind a proxy using HTTPS (prevents loops)
RUN printf "<IfModule mod_setenvif.c>\nSetEnvIf X-Forwarded-Proto \"https\" HTTPS=on\n</IfModule>\n" \
  > /etc/apache2/conf-available/render-https.conf \
 && a2enconf render-https

EXPOSE 8080
