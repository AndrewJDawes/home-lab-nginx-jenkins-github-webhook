FROM nginx:1.27.1-alpine

EXPOSE 80 443

COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf