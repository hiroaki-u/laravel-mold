
FROM mysql/mysql-server:8.0

ENV TZ=Asia/Tokyo

RUN microdnf install yum
RUN yum update -y && yum install -y vim

COPY ./docker/db/my.cnf /etc/my.cnf