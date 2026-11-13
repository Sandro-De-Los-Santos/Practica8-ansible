FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# SSH server, sudo y python3 (Ansible necesita python3 en los servidores)
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo python3 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd

# Usuario ansible con password "ansible" y sudo sin password
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible

# Permitir autenticacion por password via SSH
RUN sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
