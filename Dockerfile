FROM node:12.14.1-alpine3.11

MAINTAINER "Cedric Gatay <c.gatay@code-troopers.com>"

RUN mkdir /app

COPY package.json /app
COPY package-lock.json /app

WORKDIR /app

RUN npm i

EXPOSE 3000

COPY . /app

CMD ["npx", "grunt"]