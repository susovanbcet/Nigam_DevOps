
FROM  oraclelinux:7.5
MAINTAINER Nigam Rout
 
ARG JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"

#Helpful utils, but only sudo is required
#RUN yum -y install tar
#RUN yum -y install vim
#RUN yum -y install nc
RUN yum -y install wget
#RUN yum -y install sudo
 
######## JDK7
 
#Note that ADD uncompresses this tarball automatically
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
RUN yum -y localinstall -y jdk-8u181-linux-x64.rpm
RUN yum -y install tomcat tomcat-webapps tomcat-admin-webapps
 
EXPOSE 8080





# Default disk space on a container is 10 GB
# To Increase the default container size 
#    dockerd --storage-opt dm.basesize=20G

groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

cd /opt
wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
mkdir /opt/tomcat
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1


cd /opt/tomcat
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*

chown -R tomcat webapps/ work/ temp/ logs/