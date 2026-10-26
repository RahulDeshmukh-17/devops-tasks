FROM eclipse-temurin:18-jre

WORKDIR /app

COPY target/task-1-java-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]