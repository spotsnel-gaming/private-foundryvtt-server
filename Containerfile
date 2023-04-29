#

FROM caddy:builder-alpine AS builder
RUN xcaddy build 


# ---

FROM alpine:latest

RUN apk add nodejs \
    && mkdir -p /app

COPY start.sh /app

VOLUME /data

ENTRYPOINT "/app/start.sh"

