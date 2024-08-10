# Gunakan image Nginx sebagai base image
FROM nginx:alpine

# Salin file HTML dan folder asset ke direktori /usr/share/nginx/html di dalam container
COPY lugx_gaming /usr/share/nginx/html

# Expose port 80 untuk akses HTTP
EXPOSE 80

# Jalankan Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
