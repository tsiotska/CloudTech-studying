FROM node:14-alpine as base

WORKDIR /node-app
COPY ./package*.json ./
RUN npm install
COPY . .


FROM base as production

RUN npm run build
EXPOSE 3000
CMD [ "npm", "start" ]
