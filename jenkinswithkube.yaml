# Gunakan image Jenkins sebagai base
FROM joyvinensius/jenkins-cloudflared:1.2

# Install kubectl
USER root
RUN apt-get update && \
    apt-get install -y curl && \
    curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client

# Kembali ke user Jenkins
USER jenkins
