# Use Debian as the base image
FROM debian:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Download the x-ui tar.gz file
RUN wget https://github.com/MHSanaei/3x-ui/releases/download/v2.3.15/x-ui-linux-amd64.tar.gz

# Extract the downloaded file and remove the tar.gz to save space
RUN tar -xzf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz

# Make the x-ui.sh script in the root directory executable
RUN chmod +x /x-ui.sh

# Ensure x-ui.sh runs when the container starts
CMD ["/x-ui.sh"]