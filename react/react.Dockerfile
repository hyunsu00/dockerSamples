FROM node:16.13.2-alpine

WORKDIR /app

RUN npm install -g serve

COPY ./app/build /app

EXPOSE 8101

CMD ["serve", "-l", "8101", "-s",  "./"]