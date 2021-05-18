FROM node:nginx:1.14-alpine As builder
WORKDIR /app
COPY ./SampleApp/package.json ./SampleApp/package-lock.json ./
RUN npm install -g @angular/cli
RUN npm install
COPY . .

FROM nginx:1.14-alpine
COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
EXPOSE 9191
CMD ["nginx","-g","daemon off;"]

