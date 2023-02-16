#!/bin/bash
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host
PIHOLE_VER=`cat VERSION`

docker manifest  rm pluim003/pihole-unbound:latest  
docker manifest create  pluim003/pihole-unbound:latest --amend pluim003/pihole-unbound:latest-arm64v8 --amend pluim003/pihole-unbound:latest-arm32v7 --insecure
docker manifest create  pluim003/pihole-unbound:${PIHOLE_VER} -a pluim003/pihole-unbound:latest-arm64v8 -a pluim003/pihole-unbound:latest-arm32v7 --insecure

docker manifest inspect pluim003/pihole-unbound:latest
docker manifest push pluim003/pihole-unbound:latest
docker manifest push pluim003/pihole-unbound:$PIHOLE_VER



