FROM nginx:1.27.1-alpine AS base

EXPOSE 80 443

COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

FROM base AS dev

# install Git
RUN apk add --no-cache git
