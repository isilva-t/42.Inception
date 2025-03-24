FROM debian:bullseye

RUN apt-get update && apt upgrade -y \
    && apt-get install -y \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY /tools/sql.sh /etc/mysql/sql.sh 

RUN mkdir -p /run/mysqld && chmod +x /etc/mysql/sql.sh 

CMD ["/etc/mysql/sql.sh"] 
