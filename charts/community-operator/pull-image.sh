#!/usr/bin/env bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <image> <tag>"
    exit 1
fi

registry="quay.io"
image=$1
pushImage=`echo "$image" | sed 's/-kubernetes//g' | sed 's/quay.io\/mongodb/custom.repo\/data/g' | sed  's/docker.io/custom.repo\/data/g'`
tag=$2
platform="amd64"

echo "docker pull $image:$tag"
docker pull "$image:$tag" --platform "$platform"
echo "docker tag $pushImage:$tag-$platform"
docker tag "$image:$tag" "$pushImage:$tag-$platform"
docker push "$pushImage:$tag-$platform"