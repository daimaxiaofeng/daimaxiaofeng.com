FROM node:20 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm config set registry https://registry.npm.taobao.org
COPY . .
RUN npm run build

FROM nginx:latest

COPY --from=builder /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
