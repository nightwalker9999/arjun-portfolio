# Stage 1: Build the site
FROM node:lts-alpine AS builder
WORKDIR /app

# Explicitly copy the files to ensure they exist in the context
COPY package.json ./
# If you have a lockfile now, uncomment the line below:
# COPY package-lock.json ./ 

RUN npm install

# Copy everything else
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]