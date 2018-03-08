# [Caddy](https://hub.docker.com/r/p3lim/caddy/)

Small [Caddy](https://caddyserver.com/) server for all your web hosting needs.  
See the [official docs](https://caddyserver.com/docs) for more information.

The image also comes with [inotify](http://man7.org/linux/man-pages/man7/inotify.7.html), which reloads Caddy when the configurations are changed, without any downtime.

### Build Info

- Image: [p3lim/alpine:3.7](https://github.com/p3lim/docker-alpine)
- Ports: _80, 443_
- Volumes:
	- `/config`
- Environment:
	- `PUID` (user id)
	- `PGID` (user group)
	- `TZ` (timezone, e.g. `Europe/Paris`)

### Plugins

Caddy has plugins/middleware, which this image supports.  
To add plugins you'll need to build the image manually with a build argument, as such:

```
docker build --build-arg CADDY_PLUGINS='http.ratelimit,http.http.nobots' https://github.com/p3lim/docker-caddy.git
```

The example above will add the [`http.ratelimit`](https://caddyserver.com/docs/http.ratelimit) and [`http.nobots`](https://caddyserver.com/docs/http.nobots) plugins.  
Keep in mind that [Docker Compose](https://docs.docker.com/compose/) has support for building with arguments too.
