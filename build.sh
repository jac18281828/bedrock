#!/usr/bin/env bash

export BEDROCK_VERSION=$(git rev-parse HEAD | cut -c 1-10)

VERSION=${BEDROCK_VERSION} docker-compose build --progress plain --build-arg VERSION=${BEDROCK_VERSION}
