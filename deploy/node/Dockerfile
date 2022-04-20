FROM node:14.16.1

WORKDIR /usr/src/app

COPY ../../package*.json ./

RUN npm install

COPY ../../ .

RUN npm build

EXPOSE 8080
# CMD [ "npm", "start" ]
