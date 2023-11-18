#!/bin/bash -e
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
touch /run/openrc/softlevel
rc-service unbound start
/usr/bin/start.sh
