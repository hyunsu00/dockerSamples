#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

echo "push : docker.io/hyunsu00/clean-centos:7"
{
    docker push hyunsu00/clean-centos:7

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/clean-centos:7"
    else
        echo "failed : docker.io/hyunsu00/clean-centos:7"
        exit 1
    fi
}

echo "push : docker.io/hyunsu00/clean-rockylinux:8"
{
    docker push hyunsu00/clean-rockylinux:8

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/clean-rockylinux:8"
    else
        echo "failed : docker.io/hyunsu00/clean-rockylinux:8"
        exit 1
    fi
}

echo "push : docker.io/hyunsu00/clean-ubuntu:22.04"
{
    docker push hyunsu00/clean-ubuntu:22.04

    if [ $? -eq 0 ]; then
        echo "succeed : docker.io/hyunsu00/clean-ubuntu:22.04"
    else
        echo "failed : docker.io/hyunsu00/clean-ubuntu:22.04"
        exit 1
    fi
}
