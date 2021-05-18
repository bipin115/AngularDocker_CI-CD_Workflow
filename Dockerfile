FROM node:current-alpine As builder
WORKDIR /app
COPY ./SampleApp/package.json ./SampleApp/package-lock.json ./
RUN npm uninstall -g @angular/cli
RUN npm cache clean --force
RUN npm install -g  @angular/cli@latest
RUN npm install
COPY . .
RUN ng build

FROM nginx:current-alpine
COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
EXPOSE 9191
CMD ["nginx","-g","daemon off;"]

