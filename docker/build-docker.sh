#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-gainprox/gainproxd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/gainproxd docker/bin/
cp $BUILD_DIR/src/gainprox-cli docker/bin/
cp $BUILD_DIR/src/gainprox-tx docker/bin/
strip docker/bin/gainproxd
strip docker/bin/gainprox-cli
strip docker/bin/gainprox-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
