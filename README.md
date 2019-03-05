# [Caddy](https://hub.docker.com/r/p3lim/caddy/)

Small [Caddy](https://caddyserver.com/) server for all your web hosting needs.  
See the [official docs](https://caddyserver.com/docs) for more information.

The image also comes with [inotify](http://man7.org/linux/man-pages/man7/inotify.7.html), which will watch the config volume for changes, validate the configs, then gracefully reload Caddy without any downtime.

### Build Info

- Image: [p3lim/alpine:3.8](https://github.com/p3lim/docker-alpine)
- Ports: _80, 443_
- Volumes:
	- `/config` - Caddyfile(s) location
	- `/logs` - log files
	- `/data` - certificates/keys
- Environment:
	- `PUID` (user id)
	- `PGID` (user group)
	- `TZ` (timezone, e.g. `Europe/Paris`)
