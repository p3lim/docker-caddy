FROM p3lim/alpine:3.7

ARG CADDY_PLUGINS=''

# set home for the user (acme needs this)
ENV HOME='/config'

# install dependencies
RUN apk add --no-cache curl libcap inotify-tools

# install Caddy with plugins
RUN curl -Lo /tmp/caddy.tar.gz "https://caddyserver.com/download/linux/amd64?license=personal&plugins=$CADDY_PLUGINS"
RUN tar -xzf /tmp/caddy.tar.gz -C /usr/local/bin/

# give Caddy permissions to reserve low ports
RUN setcap cap_net_bind_service=+ep /usr/local/bin/caddy

# copy local files
COPY root/ /

# expose ourselves
EXPOSE 80 443
VOLUME /config
