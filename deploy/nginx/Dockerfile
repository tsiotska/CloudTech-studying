FROM nginx:1.19.8-alpine as base

RUN rm /etc/nginx/conf.d/default.conf
COPY ./deploy/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./public/ /var/www/nginx/
EXPOSE 80
CMD [ "/bin/sh", "-c", "nginx -g 'daemon off;'" ]


FROM base as development
COPY ./deploy/nginx/cloud-tech.conf /etc/nginx/conf.d/cloud-tech.conf
RUN mkdir -p /ssl

FROM base as production
COPY ./deploy/nginx/cloud-tech.prod.conf /etc/nginx/conf.d/cloud-tech.conf



