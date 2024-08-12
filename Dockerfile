# Gunakan image Ubuntu 22.04 sebagai dasar
FROM ubuntu:22.04

# Gunakan root untuk menginstal Nginx, sudo, dan utilitas tambahan
USER root

# Install Nginx, sudo, dan utilitas lainnya
RUN apt-get update && \
    apt-get install -y nginx sudo curl

# Hapus file konfigurasi Nginx yang ada
RUN rm -f /etc/nginx/sites-available/default && \
    rm -f /etc/nginx/sites-enabled/default

# Salin file konfigurasi Nginx ke dalam container
COPY nginx-config/default /etc/nginx/sites-available/default

# Buat symlink untuk mengaktifkan konfigurasi
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Salin file HTML dan folder asset ke direktori /usr/share/nginx/html di dalam container
COPY lugx_gaming /usr/share/nginx/html

# Expose port 80 untuk akses HTTP
EXPOSE 80

# Jalankan Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
