FROM alpine:3.20

RUN apk update && apk add --no-cache \
    wget \
    ca-certificates

WORKDIR /app

RUN wget https://github.com/portainer/portainer/releases/download/2.27.1/portainer-2.27.1-linux-amd64.tar.gz \
    && tar -xzf portainer-2.27.1-linux-amd64.tar.gz \
    && rm portainer-2.27.1-linux-amd64.tar.gz


COPY /tools/port.sh .
RUN chmod +x port.sh

CMD ["./port.sh"]

