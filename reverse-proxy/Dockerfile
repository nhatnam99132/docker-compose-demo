FROM nginx:latest

# Copy main nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
