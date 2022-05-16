FROM tomcat:8.0
COPY target/petApp-*.war /usr/local/tomcat/webapps/petApp.war
ADD https://tomcat.apache.org/tomcat-5.5-doc/appdev/sample/sample.war /usr/local/tomcat/webapps/