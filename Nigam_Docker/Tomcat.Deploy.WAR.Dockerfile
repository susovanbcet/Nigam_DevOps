#  .................................... DockerFile ....................................
#
#  Description: Deploy jenkins.war file on tomcat and install Ansible
#
#  docker image build -f ./Dockerfile.Tomcat.Deploy.WAR -t nigamrout/jenkins .
#  docker push nigamrout/jenkins
#
#  docker network create ansinet
#  docker container run -d --name jenkins-server1 --net ansinet nigamrout/jenkins bash
#
#  ....................................................................................

FROM tomcat

LABEL maintainer="https://hub.docker.com/r/nigamrout/"

ARG WAR_File_Name=http://mirrors.jenkins.io/war/latest/jenkins.war
ARG TOMCAT_HOME=/usr/local/tomcat

# Install pre-requisites for Ansible & OPEN SSH Server
# RUN apt-get update -y
# RUN apt-get install software-properties-common -y
# RUN apt-add-repository ppa:ansible/ansible -y
# RUN apt-get install openssh-client -y
# RUN apt-get update -y
# RUN apt-get install ansible -y
# RUN apt-get install vim -y

RUN apt-get update && apt-get install -y --no-install-recommends
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update -y
RUN apt-get install ansible -y

# Copy .war file to tomcat webapps folder
ADD ${WAR_File_Name} /usr/local/tomcat/webapps/

# Create a symolic link for 'python' to python 3.5
RUN ln -sf /usr/bin/python3.5 /usr/bin/python

# Exposing ports
EXPOSE 8080

WORKDIR $TOMCAT_HOME/bin/
# Run the Tomcat service
CMD ["startup.sh", "run"]
