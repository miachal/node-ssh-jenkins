FROM ubuntu:20.10

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl openssh-server openjdk15-jdk maven && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
    \. /root/.nvm/nvm.sh && \
    nvm install --lts && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    useradd -m -s /bin/bash jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2

#COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.m2

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
    
