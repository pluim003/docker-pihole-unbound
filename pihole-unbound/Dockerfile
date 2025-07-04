ARG PIHOLE_VERSION
FROM pihole/pihole:latest

# default versions

ENV UNBOUND_VERSION=1.23.0

# install git

RUN apk update && apk add git

# install pihole_adlist_tool (from repository by yubiuser)

RUN git clone https://github.com/yubiuser/pihole_adlist_tool.git
COPY pihole_adlist_tool/pihole_adlist_tool /usr/local/bin
RUN chmod +x /usr/local/bin/pihole_adlist_tool

# run update and install software

#RUN apk update && \
# apk install -y -f openssl wget build-essential libssl-dev libexpat-dev bison flex

# create unbound-user

RUN addgroup --gid 102 unbound
RUN adduser --uid 101 unbound --ingroup unbound --disabled-password

# add some directories

RUN mkdir -p /var/log/unbound
RUN mkdir -p /var/lib/unbound
RUN chown -R unbound:unbound /var/log/unbound

# get latest unbound and compile it

RUN apk update && apk add unbound

#RUN wget https://nlnetlabs.nl/downloads/unbound/unbound-latest.tar.gz
#RUN tar xzf unbound-latest.tar.gz

#RUN ls -l && \
# cd unbound-${UNBOUND_VERSION} && \
# ls -l && \
# ./configure && \
# make && \
# sudo make install


# RUN cp /usr/local/sbin/* /usr/sbin/

# copy some files

COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run

# to be on the safe side 2 times a copy of unbound.conf

COPY unbound.conf /var/lib/unbound/unbound.conf
RUN chmod 644 /var/lib//unbound/unbound.conf
COPY unbound.conf /usr/local/etc/unbound/unbound.conf
RUN chmod 644 /usr/local/etc/unbound/unbound.conf
COPY unbound-logrotate /etc/unbound/logrotate
RUN chmod 644 /etc/unbound/logrotate

COPY unbound-cron /etc/cron.d/unbound
RUN chmod 644 /etc/cron.d/unbound

COPY lighttpd-logrotate /etc/lighttpd/logrotate
RUN chmod 644 /etc/lighttpd/logrotate

COPY lighttpd-cron /etc/cron.d/www-data
RUN chmod 644 /etc/cron.d/www-data

COPY unbound-package-helper /usr/lib/unbound/package-helper
RUN chmod 755 /usr/lib/unbound/package-helper

RUN curl https://www.internic.net/domain/named.root -o /var/lib/unbound/root.hints
# RUN cp /usr/share/dns/root.key /var/lib/unbound/
RUN chown -R unbound:unbound /var/lib/unbound

# install pihole-cloudsync (from repository by Steve Jenkins)

COPY pihole-cloudsync/pihole-cloudsync /usr/local/bin
RUN chmod +x /usr/local/bin/pihole-cloudsync

COPY custom-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh


LABEL org.opencontainers.image.authors="Dick Pluim" \
      org.opencontainers.image.title="pluim003/pihole-unbound" \
      org.opencontainers.image.description="Run Pi-Hole + Unbound on Docker" \
      org.opencontainers.image.url="https://github.com/pluim003/docker-pihole-unbound" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/pluim003/docker-pihole-unbound" \
      org.opencontainers.image.original_source="https://github.com/cbcrowe/docker-pihole-unbound"

# ENTRYPOINT ./s6-init
ENTRYPOINT ["/custom-entrypoint.sh"]
