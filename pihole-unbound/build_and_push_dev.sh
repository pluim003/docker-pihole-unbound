#!/bin/bash
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host
PIHOLE_VER=dev

docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm64/v8 -f Dockerfile_dev -t pluim003/pihole-unbound:dev-arm64v8 --push .

docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm/v7 -f Dockerfile_dev -t pluim003/pihole-unbound:dev-arm32v7 --push .

docker manifest  rm pluim003/pihole-unbound:dev  pluim003/pihole-unbound:dev-arm64v8 pluim003/pihole-unbound:dev-arm32v7 
docker manifest create  pluim003/pihole-unbound:dev -a pluim003/pihole-unbound:dev-arm64v8 -a pluim003/pihole-unbound:dev-arm32v7

docker manifest inspect pluim003/pihole-unbound:dev
docker manifest push pluim003/pihole-unbound:dev
