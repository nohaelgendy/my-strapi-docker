FROM node:16
RUN apt-get update && apt-get install libvips-dev -y 
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json package-lock.json ./ 
ENV PATH /opt/node_modules/.bin:$PATH 
RUN npm config set network-timeout 600000 -g && npm install

WORKDIR /opt/app
COPY ./ .
RUN npm build 
EXPOSE 1337 
CMD ["npm", "run", "develop"]


# # FROM node:18-alpine3.18
    # FROM node:16.x-alpine AS builder
    # # Installing libvips-dev for sharp Compatibility
    # RUN sed -i -e 's/https/http/g' /etc/apk/repositories 
    # RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
    # ARG NODE_ENV=development
    # ENV NODE_ENV=${NODE_ENV}

    # WORKDIR /opt/
    # COPY package.json package-lock.json ./
    # RUN npm install -g node-gyp
    # RUN npm config set fetch-retry-maxtimeout 600000 -g && npm install
    # ENV PATH=/opt/node_modules/.bin:$PATH

    # WORKDIR /opt/app
    # COPY . .
    # RUN chown -R node:node /opt/app
    # USER node
    # RUN ["npm", "run", "build"]
    # EXPOSE 1337
    # CMD ["npm", "run", "develop"]
