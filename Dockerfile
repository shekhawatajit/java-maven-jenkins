# Using oracle linux base with JDK 17 and maven 3.6.3 installed on it
# details are available https://hub.docker.com/layers/library/maven/3.6.3-openjdk-17/images/sha256-c74c4d8f7b470c2c47ba3fcb7e33ae2ebd19c3a85fc78d7b40c8c9a03f873312?context=explore
FROM maven:3.6.3-openjdk-17 AS build-env
# Setting up work directory in container
WORKDIR /App

# Copy code from repository to container
COPY . ./
# Compile code
RUN mvn compile
# Build code
RUN mvn package

# Using runtime image to execute application
FROM maven:3.6.3-openjdk-17 AS runtime-env
# Setting up work directory in container
WORKDIR /App
# copying compiled code (jar file) from build container to this container
COPY --from=build-env /App/target .
# executing application
ENTRYPOINT exec java -jar java-maven-sample-app-1.0.jar