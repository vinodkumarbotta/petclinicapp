FROM tomcat:8.0
ADD target/petApp-*.war /usr/local/tomcat/webapps/petApp.war