ARG PIHOLE_VERSION
FROM pihole/pihole:${PIHOLE_VERSION:-latest}

COPY debian_testing.list /etc/apt/sources.list.d/

RUN apt update && apt install -y -f unbound

RUN mkdir -p /var/log/unbound
RUN chown -R unbound:unbound /var/log/unbound
COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run

COPY unbound-logrotate /etc/unbound/logrotate
RUN chmod 644 /etc/unbound/logrotate

COPY unbound-package-helper /usr/lib/unbound/package-helper
RUN chmod 755 /usr/lib/unbound/package-helper

RUN curl https://www.internic.net/domain/named.root -o /var/lib/unbound/root.hints
RUN chown -R unbound:unbound /var/lib/unbound/root.hints

ENTRYPOINT ./s6-init

