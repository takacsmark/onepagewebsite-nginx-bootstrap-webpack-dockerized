FROM node:9.11.2-alpine as builder

WORKDIR /usr/src/app
COPY package.json package-lock.json webpack.config.js postcss.config.js src ./
COPY src ./src
COPY img ./img

RUN npm install && \
    npm run build

FROM nginx:1.15.1-alpine

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html/public