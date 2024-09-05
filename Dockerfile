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

# Copy the files and set correct permissions (this may depend on the specific setup)
RUN chmod +x /app/x-ui/x-ui.sh
RUN cp /app/x-ui/x-ui.service /etc/systemd/system/

# Expose necessary ports (2053 is default in the repo)
EXPOSE 2053

# Start the service
CMD ["bash", "/app/x-ui/x-ui.sh"]