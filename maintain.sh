#!/bin/bash

echo_hits="======>"
echo_subHits="  ====>"
USAGE="
Usage:
  $0 [c|i]
  $0 -h|--help
Options:
  c, container    remove existed docker containers
  i, image        remove dangling docker images
"

# usage
if [[ "$@" = *--help ]] || [[ "$@" = *-h ]]; then
  echo "$USAGE"
  exit 1
fi

# flag to maintain docker
if [[ $# > 1 ]]; then
    echo "$echo_hits" WRONG param num
    echo "$USAGE"
    exit 1
elif [[ "$1" = "image" ]] || [[ "$1" = "i" ]]; then
    # docker images prune
    # TODO 看看有没有更好的实现方式
    if [[ ! -z $(docker images -f dangling=true -aq) ]]; then
        docker rmi $(docker images -f dangling=true -aq)
    else
        echo "$echo_hits no docker dangling images found"
    fi
elif [[ "$1" = "container" ]] || [[ "$1" = "c" ]]; then
    docker container prune -f
    # # TODO 看看有没有更好的实现方式
    # if [ ! -z $(docker container ls -f status=exited -aq) ]; then
    #     docker rm $(docker container ls -f status=exited -aq)
    # else
    #     echo "$echo_hits no docker exited container found"
    # fi
else
    echo "$echo_hits" WRONG param val
    echo "$USAGE"
    exit 1
fi
