#!/usr/bin/env bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <image> <tag>"
    exit 1
fi

registry="quay.io"
image=$1
pushImage=`echo $image | sed 's/enterprise-//g'`
tag=$2
platform="amd64"

echo "docker pull $registry/mongodb/$image:$tag"
docker pull "$registry/mongodb/$image:$tag" --platform "$platform"
echo "docker tag $registry/mongodb/$image:$tag-$platform"
docker tag "$registry/mongodb/$image:$tag" "custom.repo/data/$pushImage:$tag-$platform"
docker push custom.repo/data/$pushImage:$tag-$platform