FROM tomcat
ADD target/petApp-*.war /usr/local/tomcat/webapps/petApp.war
EXPOSE 8080
CMD ["catalina.sh", "run"]