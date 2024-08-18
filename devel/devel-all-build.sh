#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

echo "build : docker.io/hyunsu00/devel-node:16.13.2-bullseye"
{
    docker build \
        -t hyunsu00/devel-node:16.13.2-bullseye \
        -f ./devel-node16.13.2-bullseye.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-node:16.13.2-bullseye"
    else
        echo "failed : docker.io/hyunsu00/devel-node:16.13.2-bullseye"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/devel-centos:7"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devpro \
        -t hyunsu00/devel-centos:7 \
        -f ./devel-centos7.Dockerfile .
    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-centos:7"
    else
        echo "failed : docker.io/hyunsu00/devel-centos:7"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/devel-rockylinux:8"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devpro \
        -t hyunsu00/devel-rockylinux:8 \
        -f ./devel-rockylinux8.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-rockylinux:8"
    else
        echo "failed : docker.io/hyunsu00/devel-rockylinux:8"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/devel-ubi8:8.6"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devpro \
        -t hyunsu00/devel-ubi8:8.6 \
        -f ./devel-ubi8.8.6.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-ubi8:8.6"
    else
        echo "failed : docker.io/hyunsu00/devel-ubi8:8.6"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/devel-ubi9:9.2"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devpro \
        -t hyunsu00/devel-ubi9:9.2 \
        -f ./devel-ubi9.9.2.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-ubi9:9.2"
    else
        echo "failed : docker.io/hyunsu00/devel-ubi9:9.2"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/devel-ubuntu:22.04"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devpro \
        -t hyunsu00/devel-ubuntu:22.04 \
        -f ./devel-ubuntu22.04.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/devel-ubuntu:22.04"
    else
        echo "failed : docker.io/hyunsu00/devel-ubuntu:22.04"
        exit 1
    fi
}
