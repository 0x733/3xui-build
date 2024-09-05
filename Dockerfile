# Base image olarak Debian kullanıyoruz
FROM debian:latest

# Gerekli bağımlılıkları kuruyoruz
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Çalışma dizini belirliyoruz
WORKDIR /app

# x-ui tar.gz dosyasını indiriyoruz
RUN wget https://github.com/MHSanaei/3x-ui/releases/download/v2.3.15/x-ui-linux-amd64.tar.gz

# İndirilen dosyayı çıkarıyoruz
RUN tar -xzf x-ui-linux-amd64.tar.gz

# install.sh çalıştırılabilir hale getiriyoruz ve çalıştırıyoruz
RUN chmod +x /app/install.sh && ./install.sh

# x-ui.sh dosyasını çalıştırılabilir hale getiriyoruz
RUN chmod +x /app/x-ui.sh

# Container başlatıldığında x-ui.sh'nin çalışmasını sağlıyoruz
CMD ["/app/x-ui.sh"]