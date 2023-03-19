# Dockerfile for production
# Multi-Step build process will be used in this file

#Build Phase(1st base image)
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

#Run Phase(2nd base image)
FROM nginx
# We copy data from the first phase therefore we use the following syntax.
# All the data that we need for production is available in the /app/build, therefore we only copy that data into the container
# /usr/share/nginx/html -> this is the default path where the data should be stored in the container
COPY --from=0 /app/build /usr/share/nginx/html