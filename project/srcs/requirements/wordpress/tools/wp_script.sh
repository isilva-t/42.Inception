#!/bin/bash

SQL_USER=$(cat /run/secrets/sql_user)
SQL_PASS=$(cat /run/secrets/sql_pass)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)

echo "Database connection check..."
max_retries=30
counter=0
while ! mysql -h mariadb -u $SQL_USER -p$SQL_PASS -e "SELECT 1" >/dev/null 2>&1; do
    counter=$((counter+1))
    if [ $counter -gt $max_retries ]; then
        echo "Database connection failed after $max_retries attempts. Exiting."
        exit 1
    fi
    echo "Database not ready yet. Waiting 5 seconds... (Attempt $counter/$max_retries)"
    sleep 5
done
echo "Database connection successful! Continuing with WordPress setup..."
sleep 2

cd /var/www/html
if [ ! -f "wp-config.php" ]; then

echo "installing wordpress stuff"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root

./wp-cli.phar config create \
	--dbname=$SQL_DB \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASS \
	--dbhost=mariadb \
	--allow-root

./wp-cli.phar core install \
	--url=$WP_URL \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root

./wp-cli.phar user create \
	$WP_USER $WP_USER_EMAIL \
	--role=subscriber \
	--user_pass=$WP_USER_PASS \
	--allow-root


./wp-cli.phar option update comment_registration 1 --allow-root

./wp-cli.phar theme install oceanwp --allow-root
./wp-cli.phar theme activate oceanwp --allow-root

./wp-cli.phar plugin install redis-cache --activate --allow-root
./wp-cli.phar config set WP_REDIS_HOST redis --allow-root
./wp-cli.phar config set WP_REDIS_PORT 6379 --allow-root
./wp-cli.phar config set WP_CACHE true --allow-root
./wp-cli.phar redis enable --allow-root

else
	echo "wordpress stuff already installed, starting service..."
fi

chown -R www-data:www-data /var/www/html/
chmod -R 777 /var/www/html/ 

unset SQL_USER SQL_PASS WP_ADMIN_USER WP_ADMIN_PASS WP_ADMIN_EMAIL \
		WP_USER WP_USER_EMAIL WP_USER_PASS

exec /usr/sbin/php-fpm7.4 -F
