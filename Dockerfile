#mi first image
ARG alpine_version=latest
FROM alpine:${alpine_version} AS base
ARG buildno=1

WORKDIR /
WORKDIR /app
WORKDIR build
# / + app + build = /app/build
RUN touch test2.txt && echo "Hello World" > test3.txt

COPY tomcat.tar.gz /app

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz && \
    tar -xvf apache-tomcat-9.0.89.tar.gz && \
    rm apache-tomcat-9.0.89.tar.gz


FROM alpine:${alpine_version}
RUN apk add openjdk17
COPY --from=base /app/build/apache-tomcat-9.0.89 /app/build/apache-tomcat-9.0.89

EXPOSE 8081
ENTRYPOINT ["/app/build/apache-tomcat-9.0.89/bin/catalina.sh"]
CMD ["run"]


