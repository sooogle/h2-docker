FROM openjdk:8-jre-alpine

ENV DATA_DIR /opt/h2/data
ENV DISTRIBUTION_URL http://www.h2database.com/h2-2019-03-13.zip

RUN apk update && apk add --no-cache curl
RUN mkdir -p ${DATA_DIR} \
    && curl ${DISTRIBUTION_URL} -o h2.zip \
    && unzip h2.zip -d /opt/ \
    && rm h2.zip

COPY h2.server.properties /root/.h2.server.properties
EXPOSE 5435 8082 9092
WORKDIR ${DATA_DIR}

CMD java -cp /opt/h2/bin/h2*.jar org.h2.tools.Server \
    -web -webAllowOthers \
    -tcp -tcpAllowOthers \
    -pg -pgAllowOthers \
    -baseDir ${DATA_DIR} ${H2_OPTIONS}