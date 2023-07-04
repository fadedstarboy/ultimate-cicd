# Base image
FROM openjdk:8-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file to the container
COPY ./target/*.jar /app.jar

# Set the command to run the JAR file
CMD ["java", "-jar", "app.jar"]