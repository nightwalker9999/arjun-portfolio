# Stage 1: Build the site
FROM node:lts-alpine AS builder
WORKDIR /app

# Copy dependency files first (better caching)
COPY package*.json ./
RUN npm install

# Copy the rest and build
COPY . .
RUN npm run build

# Stage 2: Serve the site
FROM nginx:alpine AS runtime
# Copy the custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy the build output
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]