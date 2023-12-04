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

COPY unbound.conf /etc/unbound/unbound.conf
RUN chmod 644 /etc/unbound/unbound.conf
COPY unbound-logrotate /etc/unbound/logrotate
RUN chmod 644 /etc/unbound/logrotate

COPY unbound-cron /etc/cron.d/unbound
RUN chmod 644 /etc/cron.d/unbound

COPY unbound-package-helper /usr/lib/unbound/package-helper
RUN chmod 755 /usr/lib/unbound/package-helper

RUN curl https://www.internic.net/domain/named.root -o /var/lib/unbound/root.hints
RUN chown -R unbound:unbound /var/lib/unbound/root.hints

# install pihole_adlist_tool (from repository by yubiuser)

RUN git clone https://github.com/yubiuser/pihole_adlist_tool.git
COPY pihole_adlist_tool/pihole_adlist_tool /usr/local/bin
RUN chmod +x /usr/local/bin/pihole_adlist_tool

# install pihole-cloudsync (from repository by Steve Jenkins)

COPY pihole-cloudsync/pihole-cloudsync /usr/local/bin
RUN chmod +x /usr/local/bin/pihole-cloudsync

LABEL org.opencontainers.image.authors="Dick Pluim" \
      org.opencontainers.image.title="pluim003/pihole-unbound" \
      org.opencontainers.image.description="Run Pi-Hole + Unbound on Docker" \
      org.opencontainers.image.url="https://github.com/pluim003/docker-pihole-unbound" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/pluim003/docker-pihole-unbound" \
      org.opencontainers.image.original_source="https://github.com/cbcrowe/docker-pihole-unbound"

ENTRYPOINT ./s6-init

