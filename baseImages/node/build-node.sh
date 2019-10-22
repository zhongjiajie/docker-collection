#!/bin/bash

echo_hits="======>"

# usage
if [[ "$@" = *--help ]] || [[ "$@" = *-h ]]; then
  echo "Usage: $0 [version]
       if you want to build with default version(0.0.1): $0
       if you want to build with specific verion: $0 <verison>"
  exit 1
fi

# version section
DEFAULT_VERSION=6.14-alpine-git
if [ ! -z "$1" ]; then
    IMAGE_VERSION="$1"
else
    IMAGE_VERSION=$DEFAULT_VERSION
fi
echo "$echo_hits start $0 with version $IMAGE_VERSION"

# TODO 没有清除之前的版本
# TODO 输多了或者输少了参数弹出usage提示
# echo "docker build --no-cache --rm -t zhongjiajie/node:$IMAGE_VERSION ./node"
CURRENT_PATH=$(pwd)
docker build --no-cache --rm -t zhongjiajie/node:$IMAGE_VERSION $CURRENT_PATH