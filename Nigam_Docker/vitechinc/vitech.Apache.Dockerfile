# This DockerFile is for Running Apache httpd 2.4 and configuer with Tomcat
# ........................................................................................
# docker image build -f ./vitech.Apache.Dockerfile -t vitech/apache_dr .
# docker push vitech/apache_dr
#
# docker run -it -d -p 8000:80 --hostname vitechApache_dr --name vitechApache_dr vitech/apache_dr
# .........................................................................................

FROM httpd:2.4

LABEL maintainer="nigam.anand@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends libapache2-mod-jk \
 && echo "include conf/mod_jk.conf" >> /usr/local/apache2/conf/httpd.conf

COPY ${PWD}/mod_jk.conf /usr/local/apache2/conf/mod_jk.conf
COPY ${PWD}/workers.properties /usr/local/apache2/conf/workers.properties
