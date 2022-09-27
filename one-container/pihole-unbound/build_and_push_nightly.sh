#!/bin/bash
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host
PIHOLE_VER=nightly

docker buildx build --build-arg PIHOLE_VERSION=$PIHOLE_VER --platform linux/arm64/v8,linux/arm/v7,linux/amd64 -f Dockerfile_nightly -t pluim003/pihole-unbound:nightly --push .

