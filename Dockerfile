FROM golang:1.12-alpine AS build

ENV VERSION v0.11.5

# install build deps
RUN apk add --no-cache git

# clone and checkout version
RUN go get github.com/mholt/caddy/caddy
RUN go get github.com/caddyserver/builds
WORKDIR $GOPATH/src/github.com/mholt/caddy/caddy
RUN git checkout tags/$VERSION

# disable telemetry
RUN sed -i 's/var EnableTelemetry = true/var EnableTelemetry = false/' caddymain/run.go

# build
RUN go run build.go -goos=linux -goarch=amd64

FROM p3lim/alpine:3.8

# set the path to store assets
# https://caddyserver.com/docs/cli
ENV CADDYPATH "/data"

# copy binary from build stage
COPY --from=build /go/src/github.com/mholt/caddy/caddy/caddy /usr/local/bin/

# install tools
RUN apk add --no-cache libcap inotify-tools

# give Caddy permissions to reserve low ports
RUN setcap cap_net_bind_service=+ep /usr/local/bin/caddy

# copy local files
COPY root/ /

# expose ourselves
EXPOSE 80 443
VOLUME /config /logs /data
