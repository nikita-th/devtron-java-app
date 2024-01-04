# Builder stage
FROM maven:3.8.6-openjdk-11 AS builder

WORKDIR /app

# Copy pom.xml and src first for efficient caching
COPY pom.xml .
COPY src .

# Build the application
RUN mvn clean package

# Final stage
FROM openjdk:11

WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/wine-park-0.0.1-SNAPSHOT.jar /app/app.jar

# Entrypoint to start the application
ENTRYPOINT ["java","-jar","/app/app.jar"]

