#  .................................... DockerFile ....................................
#
#  Description: install Ansible on top of jenkins image
#
#  docker image build -f ./Dockerfile.cicd -t nigamrout/cicd .
#  docker push nigamrout/jenkins-ansible
#
#  docker network create ansinet
#  docker container run -d --name jenkins-server1 nigamrout/jenkins-ansible bash
#
#  ....................................................................................

FROM ubuntu:latest

ARG WAR_File_Name=http://mirrors.jenkins.io/war/latest/jenkins.war

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget

RUN mkdir /usr/local/jenkins
ADD ${WAR_File_Name} /usr/local/jenkins/
RUN chmod -R 0755 /usr/local/jenkins/
#RUN java -jar /usr/local/jenkins/jenkins.war --httpPort=9090

EXPOSE 9090

RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-add-repository ppa:ansible/ansible -y
RUN apt-get -y update
RUN apt-get -y install ansible

ENTRYPOINT ["java", "-jar", "/usr/local/jenkins/jenkins.war", "--httpPort=9090"]
CMD ["echo", "Hello-Umesh"]
