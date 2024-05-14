#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")"

docker run --rm -it --name devel-ubi9.9.2 \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
devel-ubi9:9.2 bash