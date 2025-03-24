#!/bin/bash

SQL_USER=$(cat /run/secrets/sql_user)
SQL_PASS=$(cat /run/secrets/sql_pass)
SQL_ROOT_PASS=$(cat /run/secrets/sql_root_pass)

mysqld --user=root &
PID=$!
sleep 3

mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
GRANT ALL PRIVILEGES ON *.* TO '$SQL_USER'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

mysqladmin -u root password $SQL_ROOT_PASS


kill $PID
wait $PID

unset SQL_USER SQL_PASS SQL_ROOT_PASS

exec mysqld --user=root
