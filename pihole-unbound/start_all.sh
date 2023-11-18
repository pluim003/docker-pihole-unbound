#!/bin/bash -e
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key
rc_service start unbound
/usr/bin/start.sh
