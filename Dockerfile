FROM maven:alpine
ENV ZK_HOSTS=localhost:2181 \
    LISTEN=9000
RUN curl -sL https://github.com/yanlinw/Kafdrop/archive/master.zip > /tmp/master.zip \
    && unzip /tmp/master.zip -d /tmp \
    && cd /tmp/Kafdrop-master \
    && mvn package \
    && cp ./target/kafdrop-*.jar /usr/local/bin/kafdrop.jar \
    && mvn clean \
    && rm -fr /tmp/Kafdrop-master /tmp/master.zip \
    && echo ""
RUN apk update && apk add --no-cache libc6-compat
CMD java -jar /usr/local/bin/kafdrop.jar --zookeeper.connect=${ZK_HOSTS} --server.port=${LISTEN}    --message.format=AVRO
