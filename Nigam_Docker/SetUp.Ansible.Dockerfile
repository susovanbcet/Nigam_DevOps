#  ..................................................................................
#
#  docker image build -f ./Dockerfile.AnsibleSetUp -t nigamrout/ubuntu-ansible .
#  docker push nigamrout/ubuntu-ansible
#
#  docker network create ansinet
#  docker container run -it -d --name controller -h controller --net ansinet -p 22 -v ssh-vol:/home/devops/.ssh nigamrout/ubuntu-ansible bash
#  ..................................................................................

# DockerFile to create an Ubuntu image with OPEN SSH and Ansible Installed

FROM ubuntu as nigamAnsible

LABEL maintainer="https://hub.docker.com/r/nigamrout/"

# Upgrade Ubuntu
RUN apt-get update -y

# Install pre-requisites for Ansible & OPEN SSH Server
# RUN apt-get install --no-install-recommends -y software-properties-common
RUN apt-get install software-properties-common -y

# Install Ansible and OPEN SSH Server
RUN apt-add-repository ppa:ansible/ansible -y
RUN apt-get install openssh-server openssh-client -y
RUN apt-get install ansible -y
RUN apt-get install vim -y
RUN apt-get update -y


# Create the directory /var/run/sshd and set permission
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

# Create new user 'devops' and set the permission its home directory
RUN useradd -m devops
RUN chmod -R 0700 /home/devops

# Set 'devops' user Password to 'devops123'
RUN echo 'devops:devops123' | chpasswd

# switch user to 'devops'
USER devops

# Generate RSA a key with-out any password
RUN ssh-keygen -t rsa -f /home/devops/.ssh/id_rsa -P ""

# Creating file 'authorized_keys'
RUN touch /home/devops/.ssh/authorized_keys

# Printing the content of 'id_rsa.pub' file
RUN cat /home/devops/.ssh/id_rsa.pub


# switch user to 'root'
USER root
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


# Create a symolic link for 'python' to python 3.5
RUN ln -sf /usr/bin/python3.6 /usr/bin/python

# Exposing port 22
#EXPOSE 22

# Run the SSH service
CMD ["/usr/sbin/sshd", "-D"]
