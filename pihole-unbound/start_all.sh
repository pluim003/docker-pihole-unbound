#!/bin/bash -e
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
chown unbound:unbound /var/lib/unbound/root.key
/usr/bin/start.sh
touch /run/openrc/softlevel
rc-update add unbound default
rc-service unbound start
