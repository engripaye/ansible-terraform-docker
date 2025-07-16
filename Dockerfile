FROM ubuntu:22.04

# Avoid interactive prompt issues
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH and Python
RUN apt-get update && \
    apt-get install -y openssh-server python3 sudo && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
