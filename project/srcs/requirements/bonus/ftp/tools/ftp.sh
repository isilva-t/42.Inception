#!/bin/sh

FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASS=$(cat /run/secrets/ftp_pass)

chmod -R 777 /var/www/html

if ! id -u $FTP_USER > /dev/null 2>&1; then
    adduser -D $FTP_USER
fi

echo "$FTP_USER:$FTP_PASS" | chpasswd

#usermod -d /var/www/html $FTP_USER

#chown -R $FTP_USER:$FTP_USER /var/www/html

unset FTP_USER FTP_PASS

exec vsftpd /etc/vsftpd/vsftpd.conf
