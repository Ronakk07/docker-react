# this docker file is used for production mode

FROM node:alpine as main

WORKDIR '/app'

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# creating nginx server and all build folder will be put in this web-server

FROM nginx

# Port MApping for incoming traffic when deploy to cloud
EXPOSE 80
# copy something from that main (name as base image above)

# /usr/share/nginx/html this path is the by default path of nginx (checkout docker hub)
COPY --from=main '/app/build' '/usr/share/nginx/html'

