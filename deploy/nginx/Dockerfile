FROM nginx:1.19.8-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY ./deploy/nginx/cloud-tech.conf /etc/nginx/conf.d/cloud-tech.conf
COPY ./deploy/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./public/ /var/www/nginx/
RUN mkdir -p /ssl
