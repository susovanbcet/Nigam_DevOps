# This DockerFile is for Running Tomcat 8.5 on OracleLinux 7.5 with JDK 8.x
# ................................................................................................
# docker image build -f ./vitech.Tomcat.Dockerfile -t vitech/tomcat_dr .
# docker push vitech/tomcat_dr
#
# docker run -it -d -p 9090:8080 --hostname vitechTomcat_dr --name vitechTomcat_dr vitech/tomcat_dr
# .................................................................................................

FROM oraclelinux:7.5

LABEL maintainer="nigam.anand@gmail.com/"

ENV JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

USER root

RUN mkdir -p "$CATALINA_HOME" && \
    yum -y update && yum -y install wget && \
    wget --no-cookies --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" ${JDK_URL} && \
    yum -y localinstall -y jdk-8u181-linux-x64.rpm

COPY apache-tomcat-8.5.32.tar.gz .

RUN tar xvf apache-tomcat-8.5.32.tar.gz -C ${CATALINA_HOME} --strip-components=1
RUN rm -f apache-tomcat-8.5.32.tar.gz jdk-8u181-linux-x64.rpm && ls -lrt

COPY ${PWD}/index_Tomcat_8.5.32.jsp ${CATALINA_HOME}/webapps/ROOT/index.jsp

EXPOSE 8080
WORKDIR ${CATALINA_HOME}
CMD ["catalina.sh", "run"]
