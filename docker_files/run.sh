#!/bin/sh

# Replace nginx's listening port to set by Heroku
# https://devcenter.heroku.com/articles/container-registry-and-runtime#get-the-port-from-the-environment-variable
sed -i -E "s/__NGINX_LISTEN_PORT__/${PORT:-8888}/" /etc/nginx/conf.d/*.conf

mkdir -p /run/nginx /var/run/php-fpm /var/tmp/nginx/client_body
supervisord --nodaemon --configuration /etc/supervisord.conf
