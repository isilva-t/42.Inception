FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN	apt-get install -y \
    	php7.4-fpm \
	php-mysqli \
	curl \
	mariadb-client \
	redis-tools 


RUN	mkdir -p /run/php

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/.

COPY /tools/wp_script.sh .
RUN chmod +x wp_script.sh 

CMD ["./wp_script.sh"]

