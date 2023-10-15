FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-20 -y

COPY . .

RUN apt-get install maven -y
RUN mvn clear install 

FROM openjdk:20-jdk-slim
EXPOSE 8080

WORKDIR /app
COPY --from=build /target/todolist-1.0.0-jar app.jar

ENTRYPOINT [ "java","-jar", "app.jar" ]
