# caddy

[![Build and Publish Docker Image](https://github.com/zhengqunkoo/caddy/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/zhengqunkoo/caddy/actions/workflows/docker-publish.yml)

Custom [Caddy](https://caddyserver.com/) Docker image built with [xcaddy](https://github.com/caddyserver/xcaddy), bundling the following plugins:

- [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) – Cloudflare DNS provider for ACME DNS challenges
- [mholt/caddy-l4](https://github.com/mholt/caddy-l4) – Layer 4 (TCP/UDP) routing
  - `layer4` – core layer 4 app
  - `modules/l4http` – HTTP matcher for layer 4
  - `modules/l4tls` – TLS matcher for layer 4
  - `modules/l4ssh` – SSH matcher for layer 4
  - `modules/l4proxy` – proxy handler for layer 4

No docker-compose file is provided in this repository.

## Pull pre-built image

The image is published to the GitHub Container Registry on every push to `main`:

```sh
docker pull ghcr.io/zhengqunkoo/caddy:latest
```

## Build locally

```sh
docker build -t caddy-custom .
```

## Run

```sh
docker run -d \
  -p 8080:8080 \
  -p 8443:8443 \
  -v /path/to/Caddyfile:/etc/caddy/Caddyfile:ro \
  -v caddy_data:/data \
  ghcr.io/zhengqunkoo/caddy:latest
```

The container runs as UID/GID `65534` (nobody) for reduced privileges.
