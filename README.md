# dockerSamples

## CMD,ENTRYPOINT
###[Docker EntryPoint를 사용하는 방법](https://refine.dev/blog/docker-entrypoint/#introduction)
### CMD, ENTRYPOINT 요약
|                           |No ENTRYPOINT              |ENTRYPOINT exec—entry pl—entry |ENTRYPOINT ["exec—entry", “ pl—entry"]         |
|---------------------------|---------------------------|-------------------------------|-----------------------------------------------|
|No CMD                     |오류, 허용되지 않음         |/bin/sh -c exec—entry pl—entry |exec—entry pl—entry                            |
|CMD ["exec_cmd", "p1—cmd"] |exec—cmd pl—cmd            |/bin/sh -c exec—entry pl—entry |exec—entry pl—entry exec—cmd pl—cmd            |
|CMD ["p1—cmd", "p2—cmd"]   |pl—cmd p2—cmd              |/bin/sh -c exec—entry pl—entry |exec—entry pl—entry pl—cmd p2—cmd              |
|CMD exec—cmd pl—cmd        |/bin/sh -c exec—cmd pl—cmd |/bin/sh -c exec—entry pl—entry |exec—entry pl—entry /bin/sh -c exec—cmd pl-cmd |


```bash
docker build . -t cmd-entrypoint:latest -f ./CMD_ENTRYPOINT/Dockerfile
docker run cmd-entrypoint:latest
docker run cmd-entrypoint:latest echo CMD 3
docker run -it --entrypoint /bin/bash cmd-entrypoint:latest
docker run --entrypoint="" cmd-entrypoint:latest echo CMD 4
```

## systemctl
```bash
$ docker build . -t systemctl-ubuntu:22.04 -f ./systemctl/ubuntu22.04.Dockerfile
$ docker run -d --privileged --name systemctl-ubuntu \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
systemctl-ubuntu:22.04
$ docker exec -it systemctl-ubuntu bash
# 도커내부
$ systemctl status
```

```bash
$ docker build . -t systemctl-rockylinux:8.8 -f ./systemctl/rockylinux8.8.Dockerfile
$ docker run -d --privileged --name systemctl-rockylinux \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
systemctl-rockylinux:8.8
$ docker exec -it systemctl-rockylinux bash
# 도커내부
$ systemctl status
```

```bash
$ docker build . -t systemctl-centos:7 -f ./systemctl/centos7.Dockerfile
$ docker run -d --privileged --name systemctl-centos \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
systemctl-centos:7
$ docker exec -it systemctl-centos bash
# 도커내부
$ systemctl status
# State: degraded 일경우 실패한 서비스 파악
$ systemctl --failed
# State: degraded 일경우 해결
$ systemctl reset-failed
```

```bash
#
# [rockylinux에서만 설치]
# rockylinux에서는 로케일 설치를 위해서는 
# 로케일패키를 사전 설치해야 한다.
$ yum install -y glibc-locale-source

# 한국어 로케일 데이터베이스 생성
$ localedef -i ko_KR -f UTF-8 ko_KR.utf8

#
# centos 7 이상 (레드햇계열)
# /etc/locale.conf에 저장됨
# 시스템로케일 확인
$ localectl status
$ cat /etc/locale.conf
$ export
$ date
# localectl로 설정 가능한 로케일 목록 확인
$ localectl list-locales
# localectl 명령어로 로케일 변경
$ localectl set-locale "LANG=ko_KR.UTF-8"
$ source /etc/locale.conf

#
# 변경 사항 확인
#
$ localectl status
$ cat /etc/locale.conf
$ export
$ date
```

```bash
#
# ubuntu 22.04 로케일 설치를 위해서는 
# 로케일패키지를 사전 설치해야 한다.
$ apt-get install -y locales
# 한국어 로케일 데이터베이스 생성
$ localedef -i ko_KR -f UTF-8 ko_KR.utf8

#
# ubuntu 22.04
# /etc/default/locale에 저장됨
# 시스템로케일 확인
$ localectl status
$ export
$ date
# localectl로 설정 가능한 로케일 목록 확인
$ localectl list-locales
# localectl 명령어로 로케일 변경
$ localectl set-locale "LANG=ko_KR.UTF-8"
$ source /etc/default/locale

#
# 변경 사항 확인
#
$ localectl status
$ cat /etc/default/locale
$ export
$ date
```
