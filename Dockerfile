# Stage 1: Build stage using Maven
FROM maven:3.8.4-openjdk-11 AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package

# Stage 2: Create a smaller runtime image
FROM openjdk:11
COPY --from=builder /app/target/wine-park-0.0.1-SNAPSHOT.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
