FROM --platform=linux/amd64 nginx:latest

# Set working directory
WORKDIR /usr/share/nginx/html/

# Create a custom index.html file
RUN echo "<html><body><h1>Hi, I am Himanshu</h1></body></html>" > index.html

# Create writable directories for Nginx cache
RUN mkdir -p /var/cache/nginx/client_temp && \
    chmod -R 777 /var/cache/nginx

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

