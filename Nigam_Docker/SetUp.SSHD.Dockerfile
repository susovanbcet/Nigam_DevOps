#  ..................................................................................
#
#  docker image build -f ./Dockerfile.SetUp.SSHD -t nigamrout/ubuntu-sshd .
#  docker push nigamrout/ubuntu-sshd
#
#  docker network create ansinet
#  docker container run -it -d --name client1 --net ansinet nigamrout/ubuntu-sshd bash
#
#  ..................................................................................

# DockerFile

FROM ubuntu as nigamsshd

LABEL maintainer="https://hub.docker.com/r/nigamrout/"

# Upgrade and Install pre-requisites for OPEN SSH Server
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
                    software-properties-common
RUN apt-get install -y openssh-server openssh-client vim

# Create the directory /var/run/sshd with permission 0755
RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    useradd -m devops && \
    echo 'devops:devops123' | chpasswd

USER devops

# Generate RSA a key with out any password
RUN ssh-keygen -t rsa -f /home/devops/.ssh/id_rsa -P "" && \
    touch /home/devops/.ssh/authorized_keys && \
    chmod -R 0700 /home/devops && \
    cat /home/devops/.ssh/id_rsa.pub

USER root
RUN echo 'root:root' | chpasswd && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

##RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
## SSH login fix. Otherwise user is kicked off after login
##RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
##ENV NOTVISIBLE "in users profile"
##RUN echo "export VISIBLE=now" >> /etc/profile
#### RUN chmod -R 0711 /etc/ssh

# Create a symolic link for 'python' to python 3.5
RUN ln -sf /usr/bin/python3.5 /usr/bin/python

# Exposing port 22
EXPOSE 22

# Run the SSH service
CMD ["/usr/sbin/sshd", "-D"]
