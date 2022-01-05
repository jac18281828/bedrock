#!/usr/bin/env bash

VERSION=$(date +%m%d%y)

PROJECT=jac18281828/gmt

docker build --progress plain . -t ${PROJECT}:${VERSION} && \
	docker run --rm -i -t ${PROJECT}:${VERSION}
