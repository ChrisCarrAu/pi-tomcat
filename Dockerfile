FROM arm32v7/tomcat:8.0
LABEL maintainer="chris@thegravenimage.com"
EXPOSE 8080
CMD ["catalina.sh", "run"]
