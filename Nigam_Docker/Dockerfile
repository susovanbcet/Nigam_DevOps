#
# Build the image using:
# $ docker build -t eg_sshd .
#
# Run a test_sshd container
#   $ docker run -d -P --name test_sshd eg_sshd
#   $ docker port test_sshd 22
#     0.0.0.0:49154
#
# $ ssh root@192.168.1.2 -p 49154
#   The password is ``screencast``.
#   root@f38c87f2a42d:/#
#
# $ docker container stop test_sshd
# $ docker container rm test_sshd
# $ docker image rm eg_sshd

# docker image build -f ./Dockerfile -t nigamrout/sshtest --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .
# docker container run -d -it --name my_ssh_1 -h my_ssh_1 nigamrout/sshtest bash

FROM ubuntu as nigamsshd

LABEL maintainer="https://hub.docker.com/r/nigamrout/"

#Upgrade Ubuntu & Install OPEN SSH Server
RUN apt-get update -y
RUN apt-get install --no-install-recommends -y software-properties-common
RUN apt-get install openssh-server openssh-client vim -y

#Create the directory /var/run/sshd with permission 0755
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

#Create 'devops' user
RUN useradd -m devops
RUN chmod -R 0700 /home/devops
RUN echo 'devops:devops123' | chpasswd

#SSH SetUp with RSA a key
USER devops
RUN ssh-keygen -t rsa -f /home/devops/.ssh/id_rsa -P ""
RUN touch /home/devops/.ssh/authorized_keys
RUN cat /home/devops/.ssh/id_rsa.pub

USER root
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#Create a symolic link for 'python' to python 3.5
RUN ln -sf /usr/bin/python3.5 /usr/bin/python

#Expose port 22 and Run the SSH service
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
