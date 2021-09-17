#!/bin/sh
build0=$(buildah from alpine:3)
buildah run "$build0" sh -c "apk add --no-cache -q mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing &&\
  apk add --no-cache -q --update curl \
  ca-certificates \
  mediainfo \
  openssl &&\
  mkdir -p /app/sonarr/bin \
  /config \
  /downloads \
  /tv &&\
  curl -sL 'https://services.sonarr.tv/v1/download/main/latest?version=3&os=linux' | \
  tar xz -C /app/sonarr/bin --strip-components=1 &&\
  cert-sync /etc/ssl/certs/ca-certificates.crt &&\
  rm -rf /tmp/* /app/sonarr/bin/Sonarr.Update &&\
  apk del -q --no-cache curl apk-tools"
buildah config --entrypoint ["mono","/app/sonarr/bin/Sonarr.exe","-nobrowser","-data=/config"] "$build0"
buildah commit --rm "$build0" sonarr-alpine-container:latest

