# Base image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer manually using curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www

# Expose port
EXPOSE 8000

# Start server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
