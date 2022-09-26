#!/bin/bash
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host
PIHOLE_VER=`cat VERSION`

docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm64/v8 -t pluim003/pihole-unbound:$PIHOLE_VER-arm64v8 --push .
docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm64/v8 -t pluim003/pihole-unbound:latest-arm64v8 --push .

docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm/v7 -t pluim003/pihole-unbound:$PIHOLE_VER-arm32v7 --push .
docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm/v7 -t pluim003/pihole-unbound:latest-arm32v7 --push .

# docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/amd64 -t pluim003/pihole-unbound:$PIHOLE_VER-amd64 --push .
# docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/amd64 -t pluim003/pihole-unbound:latest-amd64 --push .

docker manifest  rm pluim003/pihole-unbound:latest  pluim003/pihole-unbound:latest-arm64v8 pluim003/pihole-unbound:latest-arm32v7 pluim003/pihole-unbound:latest-amd64 pluim003/pihole-unbound:$PIHOLE_VER
docker manifest create  pluim003/pihole-unbound:latest -a pluim003/pihole-unbound:latest-arm64v8 -a pluim003/pihole-unbound:latest-arm32v7 -a pluim003/pihole-unbound:latest-amd64
docker manifest create  pluim003/pihole-unbound:$PIHOLE_VER -a pluim003/pihole-unbound:$PIHOLE_VER-arm64v8 -a pluim003/pihole-unbound:$PIHOLE_VER-arm32v7 -a pluim003/pihole-unbound:$PIHOLE_VER-amd64

docker manifest inspect pluim003/pihole-unbound:latest
docker manifest push pluim003/pihole-unbound:latest
docker manifest push pluim003/pihole-unbound:$PIHOLE_VER
