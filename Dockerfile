#———stage1 - jar builder ————-

# Maven image

FROM maven:3.9.11-amazoncorretto-24-al2023 AS builder 

# Set working directory

WORKDIR /app

# Copy source code from local to container

COPY . /app

# Build application and skip test cases

#EXPOSE 8080

RUN mvn clean install -DskipTests=true

#ENTRYPOINT ["java", "-jar", "/expenseapp.jar"]

#--------------------------------------
# Stage 2 - app build
#--------------------------------------

# Import small size java image

FROM openjdk:26-oraclelinux8

WORKDIR /app 

# Copy build from stage 1 (builder)

COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Expose application port 

EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]
