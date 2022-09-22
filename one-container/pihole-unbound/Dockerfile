ARG PIHOLE_VERSION
FROM pihole/pihole:${PIHOLE_VERSION:-latest}

# Default versions
ENV UNBOUND_VERSION=1.16.3


RUN apt update && apt install -y build-essential && apt install wget
RUN apt install -y libssl-dev && apt install -y libexpat1-dev
RUN apt-get install -y bison && apt-get install -y flex

# Install Unbound

RUN wget https://nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz \
    && tar -xf unbound-${UNBOUND_VERSION}.tar.gz -C / && rm unbound-${UNBOUND_VERSION}.tar.gz

RUN cd unbound-${UNBOUND_VERSION} && ./configure && make && make install
RUN cd / && rm -rf unbound-${UNBOUND_VERSION}

COPY lighttpd-external.conf /etc/lighttpd/external.conf 
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run

ENTRYPOINT ./s6-init

