FROM node:16-alpine3.14 as builder

RUN mkdir -p /home/app
WORKDIR '/app'
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html