#
# docker image build -f ./1.Dockerfile -t nigamrout/ssh --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" --no-cache=true .
# docker image build -f ./1.Dockerfile -t nigamrout/ssh --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" --no-cache=true .

# docker container run -d -it --name my_ssh_1 -h my_ssh_1 nigamrout/ssh bash
# docker container run -d --name my_ssh_1 -h my_ssh_1 nigamrout/ssh


FROM ubuntu:16.04

#ARG ssh_prv_key
ARG ssh_pub_key

RUN apt-get update && apt-get install -y openssh-server 

# Authorize SSH Host
RUN mkdir -p /var/run/sshd && chmod 0700 /var/run/sshd && \
    # Changing passord for root user  
    echo 'root:root' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # SSH login fix. Otherwise user is kicked off after login
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    # Craeting and changing passord for devops and nigam user
    useradd -m devops && chown -R devops:devops /home/devops && echo 'devops:devops123' | chpasswd && \
    useradd -m nigam && chown -R nigam:nigam /home/nigam && echo 'nigam:anand123' | chpasswd && \
    # Creating .ssh folder for root, devops, nigam user
    mkdir -p /root/.ssh && chmod 0700 /root/.ssh && \
    mkdir -p /home/devops/.ssh && chmod 0700 /home/devops/.ssh && \
    mkdir -p /home/nigam/.ssh && chmod 0700 /home/nigam/.ssh && \
    # Coping public key from Host to Container's authorized_keys keys
    echo "$ssh_pub_key" > /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys && \
    echo "$ssh_pub_key" > /home/devops/.ssh/authorized_keys && chmod 600 /home/devops/.ssh/authorized_keys && \
    echo "$ssh_pub_key" > /home/nigam/.ssh/authorized_keys && chmod 600 /home/nigam/.ssh/authorized_keys && \
    # Print the keys -- for debuging
    echo "$ssh_pub_key"

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
