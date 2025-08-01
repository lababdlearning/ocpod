# Use a minimal base image
FROM alpine:latest

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Install tcpdump and Python (for HTTP server)
RUN apk add --no-cache tcpdump python3 py3-pip

# Set working directory
WORKDIR /home/appuser

# Expose HTTP port
EXPOSE 8080

# Switch to non-root user
USER appuser

# Run HTTP server
CMD ["python3", "-m", "http.server", "8080"]
