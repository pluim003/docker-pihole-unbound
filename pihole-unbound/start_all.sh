#!/bin/bash -e
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
/usr/bin/start.sh
touch /run/openrc/softlevel
rc-service unbound start
