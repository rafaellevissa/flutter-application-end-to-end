FROM node:17-alpine

WORKDIR /app

COPY package*.json ./

RUN npm i

COPY . ./

CMD [ "node", "ace", "serve" ]

EXPOSE 3333