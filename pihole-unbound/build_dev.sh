#!/bin/bash
VANDAAG=$(date +"%Y%m%d")

# Run this once: docker buildx create --use --name build --node build --driver-opt network=host

docker build . -f Dockerfile_test -t pluim003/pihole-unbound:${VANDAAG}


