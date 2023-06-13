FROM node:16.20.0
WORKDIR /app
COPY package.json ./
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install
COPY . .
RUN npm run build


FROM nginx:1.22.1

RUN rm -f /etc/nginx/nginx.conf && rm -f /usr/share/nginx/html/*

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY dist/ /usr/share/nginx/html/

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
