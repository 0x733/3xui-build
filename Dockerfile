# Use Debian as the base image
FROM debian:bullseye-slim

# Install dependencies, including git
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Add the necessary dependencies for the 3x-ui panel (as needed)
RUN apt-get update && apt-get install -y \
    bash \
    tar \
    gzip \
    && rm -rf /var/lib/apt/lists/*

# Clone the 3x-ui repository and set up the application
WORKDIR /app
RUN git clone https://github.com/MHSanaei/3x-ui.git /app

# First check the directory contents to debug the file structure
RUN ls -al /app

# Check again if the x-ui.sh file exists
RUN test -f /app/x-ui.sh && echo "x-ui.sh exists" || (echo "x-ui.sh not found" && exit 1)

# Set correct permissions for the x-ui.sh script
RUN chmod +x /app/x-ui.sh

# Copy the service file to the correct location
RUN cp /app/x-ui.service /etc/systemd/system/

# Expose necessary ports (2053 is default in the repo)
EXPOSE 2053

# Start the service and log the output
CMD ["bash", "/app/x-ui.sh"]