# prepare and build the Caddy binary with Tailscale support

FROM caddy:builder-alpine AS builder-unused

RUN mkdir /workspace \
    && cd /workspace \
    && git clone https://github.com/spotsnel/caddy-tailscale /workspace/ \
    && xcaddy build v2.6.4 --with github.com/tailscale/caddy-tailscale=/workspace

# or use prebuilt Caddy binary with Tailscale support instead 

FROM alpine:latest AS builder

RUN mkdir /workspace \
    && cd /workspace \
    && wget https://github.com/spotsnel/caddy-tailscale/releases/download/0.5/caddy-amd64.gz \
    && gunzip caddy-amd64.gz \
    && mv caddy-amd64 caddy \
    && chmod +x caddy

# ---

FROM alpine:latest

RUN apk add nodejs \
    && mkdir -p /app

COPY --from=builder /workspace/caddy /usr/bin/
COPY Caddyfile /app
COPY start.sh /app

VOLUME /data

ENTRYPOINT "/app/start.sh"

