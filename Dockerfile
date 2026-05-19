# Use the official Apache HTTP Server image
FROM httpd:2.4-alpine

# Copy your local HTML file into the default Apache public directory
COPY ./index.html /usr/local/apache2/htdocs/

# Expose port 80 (standard HTTP port)
EXPOSE 80
