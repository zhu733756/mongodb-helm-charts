#!/usr/bin/env bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <image> <tag>"
    exit 1
fi

registry="quay.io"
image=$1
tag=$2

platforms=(amd64 arm64)

image_name="$registry/$image:$tag"

# pull and tag images for each platform
for platform in "${platforms[@]}"; do
    echo "docker pull $registry/$image:$tag --platform $platform"
    docker pull "$registry/$image:$tag" --platform "$platform"
    docker tag "$registry/$image:$tag" "$registry/$image:$tag-$platform"
done

# push multi-arch manifest
docker manifest create "custom.repo/$image:$tag" "$registry/$image:$tag-amd64" "$registry/$image:$tag-arm64"
docker manifest push "custom.repo/$image:$tag"
