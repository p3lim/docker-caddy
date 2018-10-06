FROM p3lim/alpine:latest

# version label
ARG VERSION="0.11.0"
LABEL version="$APP_VERSION"

# build-time arguments
ARG PLUGINS=""

# set the path to store assets
# https://caddyserver.com/docs/cli
ENV CADDYPATH="/data"

# install dependencies and tools
RUN apk add --no-cache curl libcap inotify-tools

# install Caddy with plugins
RUN curl -Lo /tmp/caddy.tar.gz "https://caddyserver.com/download/linux/amd64?license=personal&plugins=$PLUGINS"
RUN tar xzf /tmp/caddy.tar.gz -C /usr/local/bin/
RUN rm /tmp/caddy.tar.gz

# give Caddy permissions to reserve low ports
RUN setcap cap_net_bind_service=+ep /usr/local/bin/caddy

# copy local files
COPY root/ /

# expose ourselves
EXPOSE 80 443
VOLUME /config /logs /data
