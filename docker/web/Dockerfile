FROM nginx:1.21.6-alpine

WORKDIR /data

RUN apk add -y --update vim less

ENV TZ=Asia/Tokyo

EXPOSE 3000

COPY ./docker/web/nginx.conf /etc/nginx/nginx.conf