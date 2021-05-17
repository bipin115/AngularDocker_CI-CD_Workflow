FROM node:current-alpine As builder
WORKDIR /app
COPY ./SampleApp/package.json ./SampleApp/package-lock.json ./
RUN ng update @angular/cli --migrate-only --from=1.4.7
RUN npm install
COPY . .
RUN npm run build

FROM nginx:current-alpine
COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
EXPOSE 9191
CMD ["nginx","-g","daemon off;"]

