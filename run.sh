#!/usr/bin/env bash

export BEDROCK_BUILD_VERSION=$(git rev-parse HEAD | cut -c 1-10)

docker-compose build --progress plain
