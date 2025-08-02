# Use Red Hat Universal Base Image for Node.js
FROM registry.access.redhat.com/ubi8/nodejs-18:latest

# Set working directory
WORKDIR /opt/app-root/src

# Copy package files first (for better caching)
COPY package*.json ./

# Install dependencies as root, then switch to user
USER 0
RUN npm install --only=production && npm cache clean --force
USER 1001

# Copy application source
COPY app.js ./

# Create a simple startup script
RUN echo '#!/bin/bash' > start.sh && \
    echo 'echo "Starting OpenShift Docker Build Demo..."' >> start.sh && \
    echo 'exec npm start' >> start.sh && \
    chmod +x start.sh

# Expose port 8080
EXPOSE 8080

# Health check (optional, for container health monitoring)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Use the startup script
CMD ["./start.sh"]
