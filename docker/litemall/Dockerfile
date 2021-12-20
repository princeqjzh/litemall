FROM openjdk:8-jre

ENV TZ "Asia/Shanghai"
ENV LANG C.UTF-8
VOLUME /tmp
WORKDIR /app

COPY application.yml application.yml
COPY litemall.jar litemall.jar
COPY config.yaml config.yaml
COPY jmx_prometheus_javaagent-0.16.1.jar jmx_prometheus_javaagent-0.16.1.jar
EXPOSE 8080 8081 1234
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-javaagent:jmx_prometheus_javaagent-0.16.1.jar=8081:config.yaml","-jar","litemall.jar"]