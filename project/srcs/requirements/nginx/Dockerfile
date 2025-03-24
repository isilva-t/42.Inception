FROM debian:bullseye

ARG CERT_PATH
ARG SSL_CERT
ARG SSL_KEY
ARG COUNTRY
ARG STATE
ARG LOCALITY
ARG ORG_NAME
ARG ORG_UNIT
ARG DOMAIN_NAME

RUN apt-get update && apt upgrade -y \
    && apt-get install -y \
    nginx \
    openssl \
    procps

RUN mkdir -p ${CERT_PATH}

COPY /conf/default /etc/nginx/sites-available/.

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ${CERT_PATH}/${SSL_KEY} \
    -out ${CERT_PATH}/${SSL_CERT} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORG_NAME}/OU=${ORG_UNIT}/CN=${DOMAIN_NAME}"



CMD ["nginx", "-g", "daemon off;"]
