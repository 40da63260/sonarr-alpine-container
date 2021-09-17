FROM alpine:3
RUN apk add --no-cache -q mono --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing"
RUN apk add --no-cache -q --update curl \
    ca-certificates \
    mediainfo \
    openssl
RUN mkdir -p /app/sonarr/bin \
    /config \
    /downloads \
    /tv
RUN curl -sL 'https://services.sonarr.tv/v1/download/main/latest?version=3&os=linux' | \
    tar xz -C /app/sonarr/bin --strip-components=1
RUN cert-sync /etc/ssl/certs/ca-certificates.crt &&\
    rm -rf /tmp/* /app/sonarr/bin/Sonarr.Update &&\
    apk del -q --no-cache curl apk-tools
EXPOSE 8989
VOLUME /downloads, /config, /tv
ENTRYPOINT ["mono","/app/sonarr/bin/Sonarr.exe","-nobrowser","-data=/config"]
