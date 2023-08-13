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