# Use official PHP with Apache
FROM php:8.2-apache

# Copy all project files into Apache web root
COPY . /var/www/html/

# Enable Apache mod_rewrite (optional but recommended)
RUN a2enmod rewrite

# Expose Render's default port
EXPOSE 8080

# Apache starts automatically
