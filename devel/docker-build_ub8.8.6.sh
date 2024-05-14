#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")"

docker build . \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t devel-ubi8:8.6 \
-f ./devel-ubi8.8.6.Dockerfile
