# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy Maven wrapper and pom.xml files
COPY ./pom.xml /app/
COPY ./mvnw /app/
COPY ./mvnw.cmd /app/

# Install dependencies
RUN ./mvnw dependency:go-offline

# Copy the rest of the application code
COPY ./src /app/src

# Build the project
RUN ./mvnw clean package

# Copy the JAR file and specify the entrypoint
COPY target/Ecom_Backendend-0.0.1-SNAPSHOT.jar ecom_backend.jar
ENTRYPOINT ["java","-jar","ecom_backend.jar"]
