FROM alpine:3.20

RUN apk update && apk add --no-cache \
    php \
    php-session \
    php-mysqli \
    php-fpm \
    wget

RUN getent group www-data > /dev/null || addgroup -S www-data && \
    getent passwd www-data > /dev/null || adduser -S -G www-data www-data

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY /tools/adminer.sh .

RUN chmod +x adminer.sh

CMD ["./adminer.sh"]
