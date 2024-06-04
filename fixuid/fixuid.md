# fixuid.md

## docker build

```bash
# fixuid 빌드
$ docker build \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=devuser \
-t fixuid \
-f ./fixuid.Dockerfile .
```

## docker run

```bash
# fixuid 실행
$ docker run -d --name fixuid \
-u "$(id -u):$(id -g)" \
-e "USER=$USER" \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
fixuid

$ docker run --rm -it -u $(id -u):$(id -g) -e "USER=$USER" \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
fixuid bash
```
