FROM ubuntu:16.04

# Upgrade Ubuntu
RUN apt-get update -y

# Install pre-requisites for OPEN SSH Server
RUN apt-get install --no-install-recommends -y software-properties-common

# Install OPEN SSH Server
RUN apt-get install openssh-server openssh-client -y
RUN apt-get install vim -y
RUN apt-get update -y

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd
RUN useradd -m devops
RUN chown -R devops:devops /home/devops
RUN echo 'devops:devops123' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

USER root
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["usr/sbin/sshd", "-D&"]
CMD ["tail", "-f", "null"]
