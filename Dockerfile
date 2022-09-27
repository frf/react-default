FROM node:16-alpine as build
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build

FROM nginx:1.15.2-alpine
WORKDIR /src
COPY --from=build /app/build /var/www
COPY --from=build /app/docker/prod/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]