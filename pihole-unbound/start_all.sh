#!/bin/bash -e
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
touch /run/openrc/softlevel
rc-service start unbound
/usr/bin/start.sh
