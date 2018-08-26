# This DockerFile is for Running Tomcat 8.5 on CoracleLinux 7.5 with JDK 8

#  ..................................................................................
#  docker image build -f ./vitech.Tomcat.Dockerfile -t vitech/tomcat .
#  docker push vitech/tomcat
#
#  docker container run -it -d -p 9000:8080 --name vitechTomcat vitech/tomcat
#  ..................................................................................

FROM oraclelinux:7.5

LABEL maintainer="nigam.anand@gmail.com/"

# Assigning JDK8 web Location in an Argument
ARG JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"

# Setting Environment Variable
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

USER root

RUN \
    # Creating Tomcat Home Directory \
    mkdir -p "$CATALINA_HOME" && \
    # Installing "wget"
    yum -y install wget && \
    # Downloading Oracle JDK8 from web   
    wget --no-cookies --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" ${JDK_URL} && \
    # Installing "JDK8"
    yum -y localinstall -y jdk-8u181-linux-x64.rpm

# Getting tomcat from Local and Installing  
COPY apache-tomcat-8.5.32.tar.gz .
RUN tar xvf apache-tomcat-8.5.32.tar.gz -C ${CATALINA_HOME} --strip-components=1

# Exposing port 8080 
EXPOSE 8080

# Setting Working Directory
WORKDIR ${CATALINA_HOME}

# Running Tomcat 
CMD ["catalina.sh", "run"]

