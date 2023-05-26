ARG TSVERSION=1.42.0
ARG TSFILE=tailscale_${TSVERSION}_ARCH.tgz

FROM alpine:latest as build
ARG TSFILE
WORKDIR /app

RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
  tsdown=$(echo $TSFILE | sed "s/ARCH/${arch}/") && \
  wget https://pkgs.tailscale.com/stable/${tsdown} && \
  tar xzf ${tsdown} --strip-components=1


FROM alpine:latest

RUN apk add nodejs \
    && mkdir -p /app

COPY --from=build /app/tailscaled /app/tailscaled
COPY --from=build /app/tailscale /app/tailscale
COPY start.sh /app

VOLUME /data

ENTRYPOINT "/app/start.sh"
