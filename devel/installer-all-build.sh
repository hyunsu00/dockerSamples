#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

echo "build : docker.io/hyunsu00/installer-centos:7"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=installpro \
        -t hyunsu00/installer-centos:7 \
        -f ./installer-centos7.Dockerfile .
    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/installer-centos:7"
    else
        echo "failed : docker.io/hyunsu00/installer-centos:7"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/installer-rockylinux:8"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=installpro \
        -t hyunsu00/installer-rockylinux:8 \
        -f ./installer-rockylinux8.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/installer-rockylinux:8"
    else
        echo "failed : docker.io/hyunsu00/installer-rockylinux:8"
        exit 1
    fi
}

echo "build : docker.io/hyunsu00/installer-ubuntu:22.04"
{
    docker build \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=installpro \
        -t hyunsu00/installer-ubuntu:22.04 \
        -f ./installer-ubuntu22.04.Dockerfile .

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/installer-ubuntu:22.04"
    else
        echo "failed : docker.io/hyunsu00/installer-ubuntu:22.04"
        exit 1
    fi
}
