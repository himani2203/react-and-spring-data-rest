FROM openjdk:11

COPY target/*.jar app.jar

EXPOSE 8080

#CMD java -jar /project/react-and-spring-data-rest-*.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
