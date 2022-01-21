#!/usr/bin/env bash

export BEDROCK_BUILD_VERSION=$(date +%m%d%y)

docker-compose build 
