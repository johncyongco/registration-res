FROM nginx:alpine

# Install envsubst for environment variable substitution
RUN apk add --no-cache gettext

# Copy nginx configuration
COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template

# Copy HTML file, favicon, and assets
COPY index.html /usr/share/nginx/html/
COPY favicon.ico /usr/share/nginx/html/
COPY Asset/ /usr/share/nginx/html/Asset/

# Expose port 80
EXPOSE 80

# Default environment variable (can be overridden)
ENV N8N_WEBHOOK_URL=YOUR_N8N_WEBHOOK_URL

# Start nginx with environment variable substitution
CMD ["/bin/sh", "-c", "envsubst '$$N8N_WEBHOOK_URL' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]