FROM openjdk:8-alpine

LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

ENV \
    TZ=UTC \
    APP_USER=appuser \
    APP_UID=1001 \
    DOCKER_GID=888

RUN apk add --no-cache --update tzdata su-exec curl ca-certificates && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /home/$APP_USER && \
    adduser -s /bin/sh -D -u $APP_UID $APP_USER && chown -R $APP_USER:$APP_USER /home/$APP_USER && \
    addgroup -g ${DOCKER_GID} docker && addgroup ${APP_USER} docker && \
    mkdir -p /srv && chown -R $APP_USER:$APP_USER /srv && \
    date && \
    rm -rf /var/cache/apk/*

WORKDIR /srv