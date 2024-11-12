# Use an official Nginx image as a base
FROM nginx:alpine

# Copy the static HTML content into the container
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

#Build the Docker Image
docker build -t webapp .
#Tag and Push the Image to a Container Registry (e.g., Docker Hub, AWS ECR)
docker tag webapp <your-repo>/webapp
docker push <your-repo>/webapp

