<%--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<%@ page session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
request.setAttribute("year", sdf.format(new java.util.Date()));
request.setAttribute("tomcatUrl", "http://tomcat.apache.org/");
request.setAttribute("tomcatDocUrl", "/docs/");
request.setAttribute("tomcatExamplesUrl", "/examples/");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>vitechinc by Nigam</title>
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <link href="tomcat.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div id="wrapper">
            <div id="navigation" class="curved container">
                <span id="nav-vitech"><a href="http://www.vitechinc.com">VitechInc</a></span>
                <span id="nav-hosts"><a href="https://docs.docker.com">Docker</a></span>
                <span id="nav-config"><a href="https://tomcat.apache.org/tomcat-8.5-doc/index.html">Tomcat</a></span>
                <span id="nav-wiki"><a href="https://docs.oracle.com/javase/8/docs/">Oracle JDK</a></span>
                <span id="nav-home"><a href="${tomcatUrl}">App Home</a></span>
                <span id="nav-help"><a href="${tomcatUrl}findhelp.html">Find Help</a></span>
                <br class="separator" />
            </div>

            <br>
            <!-- Start: Added by Nigam -->
            
            <div style="text-align:center;">  
                <font size="4" color="black">
                    It's <font color="red"> Apache Tomcat/8.5.32 </font>
                    configuration for <font color="blue">www.vitechinc.com</font> Assignment <br>
                    Server configured by <font color="green">Nigam Rout</font> using Docker, Apache and Tomcat work!
                </font>
            </div> 
            <br/> 
            <div style="text-align:center;">
                <FONT size=4 COLOR="black">
                    <b>End User</b> <FONT COLOR="blue"> =====> </FONT>
                    <b>Web Server:</b> <FONT COLOR="red"><%=request.getServerName()%>:<%=request.getServerPort()%></FONT> <FONT COLOR="blue"> =====> </FONT>
                    <b>App Server:</b> <FONT COLOR="red"> <%=java.net.InetAddress.getLocalHost()%> </FONT>
                </FONT>
            </div>

            <!-- End: Added by Nigam -->

            <div id="upper1" class="curved container">
                <div id="congrats" class="curved container">
                    <h2>Application Configured Successfully!</h2>
                </div>

                <div>
                    <font size="4" color="black"> 
                        <b> List of .yml and other files files </b>
                    </font>
                </div>
                <br/>
                <div style="text-align:left; font-family: Courier">
                    <font size="4" color="black"> 
                        $ cd /home/nigam/Nigam_DevOps/vitechinc <br/>

                        $ ls -lh <br/>
                        -rw-rw-r--. 1 nigam nigam 9.2M Jun 20 16:26 apache-tomcat-8.5.32.tar.gz <br/>
                        -rw-r-----. 1 nigam nigam 4.4K Jul 29 09:00 index_Tomcat_8.5.32.jsp <br/>
                        -rw-rw-r--. 1 nigam nigam 1.4K Jul 29 09:22 vitech.Tomcat.Dockerfile <br/>
                        <br/>
                        -rw-rw-r--. 1 nigam nigam  799 Jul 29 10:12 mod_jk.conf <br/>
                        -rw-rw-r--. 1 nigam nigam  576 Jul 29 10:40 workers.properties <br/>
                        -rw-rw-r--. 1 nigam nigam  355 Jul 29 12:37 vitech.Apache.Dockerfile <br/>
                        <br/>
                        -rw-rw-r--. 1 nigam nigam 1017 Jul 29 14:48 vitech.Docker-compose.yml <br/>

                    </font>
                </div>

                <br><br/>

                <div>
                    <font size="4" color="black"> 
                        <b> Setting up environment using "Docker run" </b>
                    </font>
                </div>                
                <br/>
                <div style="text-align:left; font-family: Courier">
                    <font size="4" color="black"> 
                        $ cd /home/nigam/Nigam_DevOps/vitechinc <br/>
                        <br/>
                        $ docker image build -f ./vitech.Tomcat.Dockerfile -t vitech/tomcat_dr .<br/>
                        <br/>
                        $ docker container run -d -p 9090:8080 \<br/>
                         &nbsp;&nbsp;&nbsp; --hostname vitechTomcat_dr --name vitechTomcat_dr \<br/>
                         &nbsp;&nbsp;&nbsp; -v tomcat_logs_dr:/usr/local/tomcat/logs vitech/tomcat_dr<br/> 
                         <br/>
                        $ docker image build -f ./vitech.Apache.Dockerfile -t vitech/apache_dr .<br/><br/>
                        $ docker container run -it -d -p 8000:80 --link vitechTomcat_dr:vitechTomcat \<br/>
                        &nbsp;&nbsp;&nbsp;--hostname vitechApache_dr --name vitechApache_dr vitech/apache_dr<br/>
                         <br/>
                         <font size="3" color="black"> 
                            <b> Out put: </b>
                        </font> 
                        <br/>
                        <font size="2" color="black" font-family="Courier"> 
                        $ docker ps -a<br/>
                        CONTAINER ID        IMAGE               COMMAND              CREATED              STATUS              PORTS                    NAMES<br/>
                        652e1303a34e        vitech/apache_dr    "httpd-foreground"   About a minute ago   Up About a minute   0.0.0.0:8000->80/tcp     vitechApache_dr<br/>
                        b379569d769e        vitech/tomcat_dr    "catalina.sh run"    2 minutes ago        Up 2 minutes        0.0.0.0:9090->8080/tcp   vitechTomcat_dr<br/>
                        <br/>
                        $ docker image ls <br/>
                        REPOSITORY                                TAG                 IMAGE ID            CREATED              SIZE<br/>
                        vitech/apache_dr                          latest              b021911d903f        About a minute ago   238MB<br/>
                        vitech/tomcat_dr                          latest              d4e03c4568fd        2 minutes ago        1.43GB<br/>
                        <none>                                    <none>              851c73fcfc84        30 minutes ago       1.43GB<br/>
                        oraclelinux                               7.5                 859a07e77c9e        4 days ago           234MB<br/>
                        httpd                                     2.4                 94af1f614752        12 days ago          178MB<br/>
                        tomcat                                    latest              61205f6444f9        7 weeks ago          467MB<br/>
                        jenkins                                   latest              07b4164f9789        7 weeks ago          696MB<br/>
                        sonarqube                                 latest              b0c238f0cb6d        2 months ago         803MB<br/>
                        docker.bintray.io/jfrog/artifactory-oss   latest              694b8e98e47c        2 months ago         1.11GB<br/>
                        <br/>
                        $ docker inspect vitechApache_dr | grep \"IPAddress\"<br/>
                                    "IPAddress": "172.17.0.3",<br/>
                                            "IPAddress": "172.17.0.3",<br/>
                        </font> <br/>
                        <br/>
                        <font size="3" color="black"> 
                            <b> Out put: </b>
                        </font> <br/>
                        <font size="2" color="black" font-family="Courier"> 
                        $ docker ps -a <br/>
                        CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                    NAMES<br/>
                        575223fb08b5        vitech/apache_dc    "httpd-foreground"   52 seconds ago      Up 51 seconds       0.0.0.0:80->80/tcp       vitechApache_dc<br/>
                        1dcf982d5fe1        vitech/tomcat_dc    "catalina.sh run"    53 seconds ago      Up 52 seconds       0.0.0.0:8080->8080/tcp   vitechTomcat_dc<br/>
                        f52693937e94        vitech/apache_dr    "httpd-foreground"   2 minutes ago       Up 2 minutes        0.0.0.0:8000->80/tcp     vitechApache_dr<br/>
                        5b3ae59deeeb        vitech/tomcat_dr    "catalina.sh run"    3 minutes ago       Up 3 minutes        0.0.0.0:9090->8080/tcp   vitechTomcat_dr<br/>
                        <br/>
                        $ docker image ls <br/>
                        REPOSITORY                                TAG                 IMAGE ID            CREATED             SIZE<br/>
                        vitech/tomcat_dc                          latest              ce07dc6056ae        53 seconds ago      1.43GB<br/>
                        vitech/apache_dc                          latest              156e7373c596        53 seconds ago      238MB<br/>
                        vitech/apache_dr                          latest              4ebd3e397373        5 minutes ago       238MB<br/>
                        vitech/tomcat_dr                          latest              9551275ddbcb        5 minutes ago       1.43GB<br/>
                        oraclelinux                               7.5                 859a07e77c9e        5 days ago          234MB<br/>
                        httpd                                     2.4                 94af1f614752        13 days ago         178MB<br/>
                        registry                                  2                   b2b03e9146e1        3 weeks ago         33.3MB<br/>
                        tomcat                                    latest              61205f6444f9        7 weeks ago         467MB<br/>
                        jenkins                                   latest              07b4164f9789        7 weeks ago         696MB<br/>
                        sonarqube                                 latest              b0c238f0cb6d        2 months ago        803MB<br/>
                        docker.bintray.io/jfrog/artifactory-oss   latest              694b8e98e47c        2 months ago        1.11GB<br/>
                        <br/>
                        $ docker inspect vitechApache_dc | grep \"IPAddress\"  <br/>
                                    "IPAddress": "",<br/>
                                            "IPAddress": "172.24.0.3",<br/><br/>
                        </font> <br/>
                    </font>
                </div>
                <br><br/>

                <div>
                    <font size="4" color="black"> 
                        <b> Setting up environment using "Docker-compose run" </b>
                    </font>
                </div>   
                <br/>
                <div style="text-align:left; font-family: Courier">
                    <font size="4" color="black"> 
                        $ cd /home/nigam/Nigam_DevOps/vitechinc <br/><br/>

                        $ docker-compose -f ./vitech.Docker-compose.yml up -d <br/> <br/>

                        $ docker-compose -f ./vitech.Docker-compose.yml down <br/> <br/>
                    </font>
                </div>

        
            
                <div id="footer" class="curved container">
                    <br>
                    <p class="copyright" style="position: relative;bottom: 50%; left: 38%;">
                        <b>Copyright ©1999 - 2018 All Rights Reserved</b>
                    </p>
                    <br>
                </div>
            
        </div>
    

</body></html>
