# fixuid.md

## docker build

```bash
# multi-state-build 빌드
$ docker build \
-t multi-state-build \
-f ./multi-state-build.Dockerfile .
```

## docker run

```bash
# fixuid 실행
$ docker run -d --name fixuid \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
 multi-state-build

$ docker run --rm -it -u $(id -u):$(id -g) \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
 multi-state-build bash
```

## mongo-c-driver

```bash
# 빌드
$ docker build -t mongo-c-driver-rockylinux -f ./mongo-c-driver.rockylinux8.Dockerfile .

# 실행
$ docker run --rm -it \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
mongo-c-driver-rockylinux \
/bin/bash
```