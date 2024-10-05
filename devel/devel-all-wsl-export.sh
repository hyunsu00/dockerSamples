#!/usr/bin/env bash

# https://learn.microsoft.com/ko-kr/windows/wsl/use-custom-distro

# 현재 스크립트 파일이 있는 디렉토리로 이동
cd "$(dirname "$0")" || exit

# wsl 폴더 생성
if [ ! -d "./wsl/" ]; then
    mkdir "./wsl/"
fi

function export_dockerContainer {
    local dockerImage=$1
    local exportFile=$2
    docker run -t $dockerImage bash ls /
    local dockerContainerID=$(docker container ls -a | grep -i $dockerImage | awk '{print $1}')
    echo "docker export $dockerContainerID :"
    docker export $dockerContainerID | gzip >$exportFile
    echo "docker rm -f $dockerContainerID :"
    docker rm -f $dockerContainerID
}

echo "export : docker.io/hyunsu00/devel-centos:7"
{
    dockerImage="hyunsu00/devel-centos:7"
    exportFile="./wsl/wsl.devel.centos7.tar.gz"
    export_dockerContainer $dockerImage $exportFile
}

# echo "export : docker.io/hyunsu00/devel-ubi8:8.6"
# {
#     dockerImage="hyunsu00/devel-ubi8:8.6"
#     exportFile="./wsl/wsl.devel.ubi8.8.6.tar.gz"
#     export_dockerContainer $dockerImage $exportFile
# }

# echo "export : docker.io/hyunsu00/devel-ubi9:9.2"
# {
#     dockerImage="hyunsu00/devel-ubi9:9.2"
#     exportFile="./wsl/wsl.devel.ubi9.9.2.tar.gz"
#     export_dockerContainer $dockerImage $exportFile
# }

echo "export : docker.io/hyunsu00/devel-rockylinux:8"
{
    dockerImage="hyunsu00/devel-rockylinux:8"
    exportFile="./wsl/wsl.devel.rockylinux8.tar.gz"
    export_dockerContainer $dockerImage $exportFile
}

echo "export : docker.io/hyunsu00/devel-ubuntu:22.04"
{
    dockerImage="hyunsu00/devel-ubuntu:22.04"
    exportFile="./wsl/wsl.devel.ubuntu22.04.tar.gz"
    export_dockerContainer $dockerImage $exportFile
}
