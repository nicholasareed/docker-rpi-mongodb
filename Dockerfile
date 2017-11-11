FROM resin/armv7hf-debian:stretch

RUN [ "cross-build-start" ]

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \
    && apt-get install -y mongodb-server \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mongodb \
    && rm -rf /etc/apt/apt.conf.d/10proxy

RUN mkdir -p /data/db /data/configdb \
    && chown -R mongodb:mongodb /data/db /data/configdb

RUN [ "cross-build-end" ]

VOLUME /data/db /data/configdb

WORKDIR /data

EXPOSE 27017
EXPOSE 28017

CMD ["mongod"]
