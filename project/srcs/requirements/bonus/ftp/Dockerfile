FROM alpine:3.20

RUN apk update && apk add --no-cache \
    vsftpd 

COPY /config/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY /tools/ftp.sh .

RUN chmod +x ftp.sh

EXPOSE 21 20 30000-30100

CMD ["./ftp.sh"]
