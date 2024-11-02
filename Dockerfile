# First stage: Build the application
FROM eclipse-temurin:17-jdk AS build

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Install dos2unix
RUN apt-get update && apt-get install -y dos2unix

# Convert line endings of mvnw to Unix format
RUN dos2unix mvnw

# Grant execute permissions to mvnw
RUN chmod +x mvnw

# Build the Spring Boot application
RUN ./mvnw clean install -DskipTests

# Second stage: Run the application
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
