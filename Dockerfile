FROM nginx:1.27.1-alpine AS base

ENV NGINX_UPSTREAM_PROTOCOL=http
ENV NGINX_UPSTREAM_PORT=80
ENV NGINX_UPSTREAM_HOST="\$upstream_host"
ENV NGINX_PROXY_PASS_LOCATION="/"

EXPOSE 80

COPY ./ /home-lab-nginx-jenkins-public-routes

WORKDIR /home-lab-nginx-jenkins-public-routes

CMD ["/bin/sh", "entrypoint.sh", "nginx", "-g", "daemon off;"]

# CMD ["nginx", "-g", "daemon off;"]

FROM base AS dev

# install Git
RUN apk add --no-cache git
