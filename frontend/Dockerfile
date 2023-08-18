FROM node:18-alpine AS build


# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy all the source code to the working directory
COPY . .

# Build the React app using Vite
RUN npm run build

# Use a lightweight web server to serve the static files
FROM nginx:alpine

# Copy the built static files from the previous stage into the Nginx web server's root directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to the host
EXPOSE 80
