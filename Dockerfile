#Dockerfile
FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y openssh-server python3 && \
    mkdir 'root:root' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]