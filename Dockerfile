# Gunakan image Ubuntu 22.04 sebagai dasar
FROM ubuntu:22.04

# Gunakan root untuk menginstal Nginx dan sudo
USER root

# Install Nginx dan sudo
RUN apt-get update && \
    apt-get install -y nginx bash sudo curl

# Salin file HTML dan folder asset ke direktori /usr/share/nginx/html di dalam container
COPY lugx_gaming /usr/share/nginx/html

# Expose port 80 untuk akses HTTP
EXPOSE 80

# Jalankan Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
