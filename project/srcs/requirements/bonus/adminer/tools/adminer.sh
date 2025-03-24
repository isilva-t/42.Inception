#!/bin/sh

mkdir -p /var/www/html/adminer

if [ ! -f /var/www/html/adminer/index.php ]; then
    echo "Adminer not found in volume, downloading..."
    wget https://github.com/vrana/adminer/releases/download/v5.0.5/adminer-5.0.5-en.php \
         -O /var/www/html/adminer/index.php
    chown -R www-data:www-data /var/www/html/adminer
    echo "Adminer downloaded successfully"
else
    echo "Adminer already exists, starting...."
fi

exec php-fpm83 -F
