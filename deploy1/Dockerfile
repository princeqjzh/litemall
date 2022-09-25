FROM openjdk:8-jre

ENV TZ "Asia/Shanghai"
ENV LANG C.UTF-8
VOLUME /tmp
WORKDIR /app

COPY application.yml application.yml
COPY litemall.jar litemall.jar
EXPOSE 8080
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-jar","litemall.jar"]