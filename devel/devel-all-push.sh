#!/usr/bin/env bash

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

echo "push : docker.io/hyunsu00/devel-node:16.13.2-bullseye"
{
    docker push hyunsu00/devel-node:16.13.2-bullseye
}

echo "push : docker.io/hyunsu00/devel-centos:7"
{
    docker push hyunsu00/devel-centos:7
}

echo "push : docker.io/hyunsu00/devel-ubi8:8.6"
{
    docker push hyunsu00/devel-ubi8:8.6
}

echo "push : docker.io/hyunsu00/devel-ubi9:9.2"
{
    docker push hyunsu00/devel-ubi9:9.2
}

echo "push : docker.io/hyunsu00/devel-rockylinux:8.8"
{
    docker push hyunsu00/devel-rockylinux:8.8
}

echo "push : docker.io/hyunsu00/devel-ubuntu:22.04"
{
    docker push hyunsu00/devel-ubuntu:22.04
}
