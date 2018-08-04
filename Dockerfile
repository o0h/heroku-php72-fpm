FROM php:7.2-fpm-alpine

RUN apk add nginx supervisor \
    && mkdir -p /etc/supervisor.d/
COPY docker_files/supervisor.programs.ini /etc/supervisor.d/

COPY docker_files/etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY docker_files/usr/local/etc/php/conf.d/php.ini /usr/local/etc/php/conf.d/php.ini
COPY docker_files/usr/local/etc/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

 COPY docker_files/run.sh /
RUN chmod a+x /run.sh
RUN adduser -D myapp \
    && apk add --update sudo \
    && echo "myapp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

 COPY ./ /var/www/html


CMD ["/run.sh"]
