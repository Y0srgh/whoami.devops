FROM node:20-slim AS build-stage

WORKDIR /app

COPY package*.json /app

RUN npm install

COPY . .

COPY . .

EXPOSE 4000

CMD ["npm", "run", "serve:ssr:frontend"]
