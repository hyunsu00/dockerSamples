
## docker build

```bash
# hyunsu00/devel-node:16.13.2-bullseye 빌드
$ docker build \
-t hyunsu00/devel-node:16.13.2-bullseye \
-f ./devel-node.16.13.2-bullseye.Dockerfile .

# hyunsu00/devel-centos:7 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t hyunsu00/devel-centos:7 \
-f ./devel-centos.7.Dockerfile .

# hyunsu00/devel-ubi8:8.6 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t hyunsu00/devel-ubi8:8.6 \
-f ./devel-ubi8.8.6.Dockerfile .

# hyunsu00/devel-ubi9:9.2 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t hyunsu00/devel-ubi9:9.2 \
-f ./devel-ubi9.9.2.Dockerfile .

# hyunsu00/devel-rockylinux:8.8 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t hyunsu00/devel-rockylinux:8.8 \
-f ./devel-rockylinux.8.8.Dockerfile .

# hyunsu00/devel-ubuntu:22.04 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t hyunsu00/devel-ubuntu:22.04 \
-f ./devel-ubuntu.22.04.Dockerfile .
```

## docker push

```bash
# 도커 허브 로그인
$ docker login -u hyunsu00
Password: dckr_pat_rQMyLeZiSbgrcYpVbCm11tEZR7Q

# docker.io/hyunsu00/devel-node:16.13.2-bullseye 저장소 push
$ docker push hyunsu00/devel-node:16.13.2-bullseye

# docker.io/hyunsu00/devel-centos:7 저장소 push
$ docker push hyunsu00/devel-centos:7

# docker.io/hyunsu00/devel-ubi8:8.6 저장소 push
$ docker push hyunsu00/devel-ubi8:8.6

# docker.io/hyunsu00/devel-ubi9:9.2 저장소 push
$ docker push hyunsu00/devel-ubi9:9.2

# docker.io/hyunsu00/devel-rockylinux:8.8 저장소 push
$ docker push hyunsu00/devel-rockylinux:8.8

# docker.io/hyunsu00/devel-ubuntu:22.04 저장소 push
$ docker push hyunsu00/devel-ubuntu:22.04
```

## docker pull

```bash
# docker.io/hyunsu00/devel-node:16.13.2-bullseye 저장소 pull
$ docker pull hyunsu00/devel-node:16.13.2-bullseye

# docker.io/hyunsu00/devel-centos:7 저장소 pull
$ docker pull hyunsu00/devel-centos:7

# docker.io/hyunsu00/devel-ubi8:8.6 저장소 pull
$ docker pull hyunsu00/devel-ubi8:8.6

# docker.io/hyunsu00/devel-ubi9:9.2 저장소 pull
$ docker pull hyunsu00/devel-ubi9:9.2

# docker.io/hyunsu00/devel-rockylinux:8.8 저장소 pull
$ docker pull hyunsu00/devel-rockylinux:8.8

# docker.io/hyunsu00/devel-ubuntu:22.04 저장소 pull
$ docker pull hyunsu00/devel-ubuntu:22.04
```

## docker run

```bash
# docker.io/hyunsu00/devel-node:16.13.2-bullseye 실행
$ docker run -d --name devel-node.16.13.2-bullseye \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/devel-node:16.13.2-bullseye

# docker.io/hyunsu00/devel-centos:7 실행
$ docker run -d --name devel-centos.7 \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
 hyunsu00/devel-centos:7

# docker.io/hyunsu00/devel-ubi8:8.6 실행
$ docker run -d --name devel-rhel.8.6 \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/devel-ubi8:8.6

# docker.io/hyunsu00/devel-ubi9:9.2 실행
$ docker run -d --name devel-rhel.9.2 \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/devel-ubi9:9.2

# docker.io/hyunsu00/devel-rockylinux:8.8 실행
$ docker run -d --name devel-rockylinux.8.8 \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/devel-rockylinux:8.8

# docker.io/hyunsu00/devel-ubuntu:22.04 실행
$ docker run -d --name devel-ubuntu.22.04 \
-e PUID=$(id -u) -e PGID=$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/devel-ubuntu:22.04
```

## wsl --import

```powershell
PS > wsl --import devel-centos7 C:\wsl\devel-centos7 C:\wsl\images\wsl.devel.centos.7.tar.gz
PS > wsl --import devel-ubi8.6 C:\wsl\devel-ubi8.6 C:\wsl\images\wsl.devel.ubi8.8.6.tar.gz
PS > wsl --import devel-ubi9.2 C:\wsl\devel-ubi9.2 C:\wsl\images\wsl.devel.ubi9.9.2.tar.gz
PS > wsl --import devel-rockylinux8.8 C:\wsl\devel-rockylinux8.8 C:\wsl\images\wsl.devel.rockylinux.8.8.tar.gz
PS > wsl --import devel-ubuntu22.04 C:\wsl\devel-ubuntu22.04 C:\wsl\images\wsl.devel.ubuntu.22.04.tar.gz
```

## wsl --unregister

```powershell
PS > wsl --unregister devel-centos7
PS > wsl --unregister devel-ubi8.6
PS > wsl --unregister devel-ubi9.2
PS > wsl --unregister devel-rockylinux8.8
PS > wsl --unregister devel-ubuntu22.04
```