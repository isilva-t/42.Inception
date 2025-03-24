FROM alpine:3.20

RUN apk update && apk add --no-cache \
    redis 

COPY /config/redis.conf /etc/.


CMD ["redis-server", "/etc/redis.conf"]
