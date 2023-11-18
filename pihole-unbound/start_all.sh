#!/bin/bash -e
# service rsyslog start
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
chown unbound:unbound /var/lib/unbound/root.key
touch /run/openrc/softlevel
rc-update add unbound default
rc-service unbound start
/usr/bin/start.sh
