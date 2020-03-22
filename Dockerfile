FROM hirokimatsumoto/alpine-openjdk-11 AS builder
ARG project=scala-vertx-action-demo
ENV SBT_VERSION 1.3.8
ENV SCALA_VERSION 2.12.10
ENV SCALA_HOME=/usr/share/scala

ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apk add curl git tar bash

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash && \
    cd "/tmp" && \
    wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

RUN \
  echo "$SCALA_VERSION $SBT_VERSION" && \
  apk add --no-cache bash curl bc ca-certificates && \
  update-ca-certificates && \
  scala -version && \
  scalac -version && \
  curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local && \
  $(mv /usr/local/sbt-launcher-packaging-$SBT_VERSION /usr/local/sbt || true) && \
  ln -s /usr/local/sbt/bin/* /usr/local/bin/ && \
  apk del curl && \
  sbt sbtVersion

RUN mkdir app
COPY . app/

WORKDIR /app

RUN sbt assembly

FROM adoptopenjdk/openjdk11:alpine-slim

WORKDIR /usr/local

COPY --from=builder /app/target/scala-2.12/scala-vertx-github-action-demo-assembly-0.1.jar ./

CMD java -jar ./scala-vertx-github-action-demo-assembly-0.1.jar

