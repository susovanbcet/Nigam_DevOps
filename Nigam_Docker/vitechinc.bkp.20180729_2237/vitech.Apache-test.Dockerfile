# This DockerFile is for Running Tomcat 8.5 on OracleLinux 7.5 with JDK 8.x
# ..........................................................................
# docker image build -f ./vitech.Apache.Dockerfile -t vitech/apache .
# docker push vitech/apache
#
# docker container run -it -d -p 9100:80 --name vitechApache vitech/apache
# ..........................................................................
#
# docker rm -f vitechApache; docker image rm -f vitech/apache; docker image build -f ./vitech.Apache.Dockerfile -t vitech/apache .; docker container run -it -d -p 9100:80 --name vitechApache vitech/apache vitechApache

FROM httpd:2.4

LABEL maintainer="nigam.anand@gmail.com/"

# Setting Working Directory
WORKDIR /usr/local/apache2
COPY apache-tomcat-8.5.32.tar.gz .

RUN apt-get update \
 && apt-get install -y --no-install-recommends libapache2-mod-jk \
 && echo "include conf/mod_jk.conf" >> /usr/local/apache2/conf/httpd.conf
# && echo "" >> /usr/local/apache2/conf/httpd.conf \
# && echo "Include /etc/apache2/mods-available/jk.load" >> /usr/local/apache2/conf/httpd.conf \
# && echo "Include /etc/apache2/mods-available/jk.conf" >> /usr/local/apache2/conf/httpd.conf 
# && mkdir -p /var/log/apache2

#COPY ${PWD}/workers.properties /etc/apache2/workers.properties 
#COPY ${PWD}/workers.properties /etc/libapache2-mod-jk/workers.properties
COPY ${PWD}/mod_jk.conf /usr/local/apache2/conf/mod_jk.conf 
COPY ${PWD}/workers.properties /usr/local/apache2/conf/workers.properties

#/etc/apache2/mods-available/jk.conf
    # We need a workers file exactly once and in the global server
#    JkWorkersFile /etc/libapache2-mod-jk/workers.properties

# Include the mod_jk configuration
#include conf/mod_jk.conf


#docker run -it --rm --name my-apache-app -e "HOSTNAME=172.17.0.4" -e "PORT=8009" --link vitechTomcat rishikeshdd/httpd:latest

#docker run -it --rm --name my-apache-app -e "HOSTNAME={Tomcat_host_name}" -e "PORT={AJP_PORT}" --link {TOMCAT_CONTAINER} rishikeshdd/httpd:latest