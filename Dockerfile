FROM debian:bullseye-slim

# Install apache2 and tcpdump
RUN apt-get update && \
    apt-get install -y apache2 tcpdump && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash apacheuser

# Create required directories and set permissions
RUN mkdir -p /home/apacheuser/apache-lock /var/run/apache2 && \
    sed -i 's|^export APACHE_LOCK_DIR=.*|export APACHE_LOCK_DIR=/home/apacheuser/apache-lock|' /etc/apache2/envvars && \
    sed -i 's|^export APACHE_RUN_USER=.*|export APACHE_RUN_USER=apacheuser|' /etc/apache2/envvars && \
    sed -i 's|^export APACHE_RUN_GROUP=.*|export APACHE_RUN_GROUP=apacheuser|' /etc/apache2/envvars && \
    chown -R apacheuser:apacheuser /var/www /var/log/apache2 /etc/apache2 /var/run/apache2 /home/apacheuser/apache-lock

# Change Apache to listen on port 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:8080/g' /etc/apache2/sites-available/000-default.conf

# Switch to non-root user
USER apacheuser

# Expose port
EXPOSE 8080

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

