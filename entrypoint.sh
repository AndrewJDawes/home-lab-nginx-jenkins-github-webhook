#!/usr/bin/env sh
envsubst '$NGINX_UPSTREAM_PROTOCOL $NGINX_UPSTREAM_HOST $NGINX_UPSTREAM_PORT' </etc/nginx/nginx.conf.template >/etc/nginx/nginx.conf
exec "$@"
