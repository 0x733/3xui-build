# Use Debian as the base image
FROM debian:bullseye-slim

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg2 \
    bash \
    tar \
    gzip \
    procps  # ps komutunu eklemek için

# Clone the 3x-ui repository and set up the application
WORKDIR /app
RUN git clone https://github.com/MHSanaei/3x-ui.git /app

# Allow bash scripts to execute
RUN chmod +x /app/x-ui.sh

# Expose necessary ports
EXPOSE 2053

# Start the service, skipping systemctl commands
CMD ["bash", "/app/x-ui.sh"]