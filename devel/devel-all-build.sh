#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

echo "build : docker.io/hyunsu00/devel-node:16.13.2-bullseye"
{
    docker build \
        -t hyunsu00/devel-node:16.13.2-bullseye \
        -f ./devel-node.16.13.2-bullseye.Dockerfile .
}

echo "build : docker.io/hyunsu00/devel-centos:7"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
        -t hyunsu00/devel-centos:7 \
        -f ./devel-centos.7.Dockerfile .
}

echo "build : docker.io/hyunsu00/devel-ubi8:8.6"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
        -t hyunsu00/devel-ubi8:8.6 \
        -f ./devel-ubi8.8.6.Dockerfile .
}

echo "build : docker.io/hyunsu00/devel-ubi9:9.2"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
        -t hyunsu00/devel-ubi9:9.2 \
        -f ./devel-ubi9.9.2.Dockerfile .
}

echo "build : docker.io/hyunsu00/devel-rockylinux:8.8"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
        -t hyunsu00/devel-rockylinux:8.8 \
        -f ./devel-rockylinux.8.8.Dockerfile .
}

echo "build : docker.io/hyunsu00/devel-ubuntu:22.04"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
        -t hyunsu00/devel-ubuntu:22.04 \
        -f ./devel-ubuntu.22.04.Dockerfile .
}
