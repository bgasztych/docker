#!/usr/bin/env bash

set -e

docker buildx build --cache-from zavenco/flutter:${FLUTTER_VERSION/+/-} \
             --tag zavenco/flutter:${FLUTTER_VERSION/+/-} \
             --build-arg flutter_version=$FLUTTER_VERSION \
             --platform=linux/arm64,linux/amd64 \
             .
