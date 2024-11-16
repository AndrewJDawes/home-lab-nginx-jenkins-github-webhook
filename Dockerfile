FROM nginx:1.27.1-alpine AS base

ENV NGINX_UPSTREAM_PROTOCOL=http
ENV NGINX_UPSTREAM_PORT=80
ENV NGINX_UPSTREAM_HOST="\$upstream_host"

EXPOSE 80

COPY /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf.template

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh", "nginx", "-g", "daemon off;"]

# CMD ["nginx", "-g", "daemon off;"]

FROM base AS dev

# install Git
RUN apk add --no-cache git
