FROM node:12.16.1-alpine As builder
WORKDIR /app
COPY ./SampleApp/package.json ./SampleApp/package-lock.json ./
COPY ./SampleApp/package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.15.8-alpine
COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
EXPOSE 9191
CMD ["nginx","-g","daemon off;"]

