FROM node:12.17-alpine As builder
WORKDIR /app
COPY ./SampleApp/package.json ./SampleApp/package-lock.json ./
RUN npm install -g @angular/cli
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.17.1-alpine
COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
EXPOSE 9191
CMD ["nginx","-g","daemon off;"]

