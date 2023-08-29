FROM adoptopenjdk/openjdk11:alpine-jre


ARG artifact=spring-boot-app/target/spring-boot-web.jar

WORKDIR /opt/app

COPY ${artifact} app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
