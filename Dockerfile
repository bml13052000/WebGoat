# FROM maven:3.6.3 AS maven
# # Create a workdir for our app
# WORKDIR /usr/src/app
# COPY . /usr/src/app

# # Compile and package the application to an executable JAR
# RUN mvn clean package -DskipTests
# # Using java 11
# FROM openjdk:11-jdk

# ARG JAR_FILE=/usr/src/app/webgoat-server/target/*.jar
# # Copying JAR file
# COPY --from=maven ${JAR_FILE} app.jar

# ENTRYPOINT ["java","-jar","/app.jar"]
FROM ubuntu
ARG  token=0

RUN apt-get update -y && \
apt-get install -y curl && \
apt-get install -y openjdk-8-jdk &&\
curl https://static.snyk.io/cli/latest/snyk-linux -o snyk && \
chmod +x ./snyk && \
mv ./snyk /usr/local/bin/ && \
ls /usr/local/bin/
COPY . /app 
RUN cd /app && \
snyk auth ${token}
# ENTRYPOINT [ "/bin/bash" ]
CMD [ "snyk","monitor","/app" ]