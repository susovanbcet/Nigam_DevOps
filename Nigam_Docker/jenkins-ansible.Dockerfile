#  .................................... DockerFile ....................................
#
#  Description: Deploy jenkins.war file on tomcat and install Ansible
#
#  docker image build -f ./Dockerfile.jenkins-ansible -t nigamrout/jenkins .
#  docker push nigamrout/jenkins-ansible
#
#  docker network create ansinet
#  docker container run -d --name jenkins-server1 nigamrout/jenkins-ansible bash
#
#  ....................................................................................

FROM ubuntu:latest


LABEL maintainer="https://hub.docker.com/r/nigamrout/"

ARG WAR_File_Name=http://mirrors.jenkins.io/war/latest/jenkins.war

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat

RUN wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-8/v8.0.52/bin/apache-tomcat-8.0.52.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.0.52/* /usr/local/tomcat/

# Copy .war file to tomcat webapps folder
ADD ${WAR_File_Name} /usr/local/tomcat/webapps/
RUN chmod -R 0755 /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "start"]

RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-add-repository ppa:ansible/ansible -y
RUN apt-get -y update
RUN apt-get -y install ansible
