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

# Use a bash script to find and run x-ui.sh
CMD ["bash", "-c", "find / -name 'x-ui.sh' -exec chmod +x {} \\; -exec {} \\;"]