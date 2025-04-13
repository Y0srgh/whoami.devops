FROM node:20-slim AS build-stage

WORKDIR /project

COPY package*.json .

RUN npm install

COPY . .

COPY . .

EXPOSE 4000

CMD ["npm", "run", "serve:ssr:frontend"]
