FROM golang:latest AS builder
RUN mkdir /build
WORKDIR /build
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4/layer4 \
    --with github.com/mholt/caddy-l4/modules/l4http \
    --with github.com/mholt/caddy-l4/modules/l4tls \
    --with github.com/mholt/caddy-l4/modules/l4ssh \
    --with github.com/mholt/caddy-l4/modules/l4proxy \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/caddy-plugins/nobots

FROM alpine
LABEL maintainer="Zhengqun Koo <root@zhengqunkoo.com>"
LABEL caddy-version="latest+cloudflare+layer4"
COPY --from=builder /build/caddy /bin/caddy
RUN chmod o+x /etc # For Caddy to resolve hostnames
USER 65534:65534
EXPOSE 8080 8443
WORKDIR /var/www/html
ENTRYPOINT ["/bin/caddy"]
CMD ["run"]
