FROM nginx:1.15.1-alpine

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY dist /usr/share/nginx/html/public