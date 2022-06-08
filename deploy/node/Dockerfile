FROM node:14-alpine as base

WORKDIR /node-app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN rm -r /node-app/src/*
EXPOSE 3000
CMD [ "npm", "start" ]


