# Use a base image with JDKs
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the jar file into the container
COPY target/music-band-booking-1.0.0.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
