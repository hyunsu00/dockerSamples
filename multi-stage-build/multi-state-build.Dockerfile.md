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
