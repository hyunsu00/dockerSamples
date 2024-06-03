# fixuid.md

## docker build

```bash
# hyunsu00/code-server 빌드
$ docker build \
-t hyunsu00/code-server \
-f ./code-server.Dockerfile .
```

## docker push

```bash
# 도커 허브 로그인
$ docker login -u hyunsu00
Password: dckr_pat_rQMyLeZiSbgrcYpVbCm11tEZR7Q

# docker.io/hyunsu00/code-server 저장소 push
$ docker push hyunsu00/code-server
```

## docker pull

```bash
# docker.io/hyunsu00/code-server 저장소 pull
$ docker pull hyunsu00/code-server
```

## docker run

```bash
# code-server 실행
$ docker run -d --name code-server \
-u $(id -u):$(id -g) \
-p 28443:8080 \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/code-server

$ docker run -it --name code-server \
-u "$(id -u):$(id -g)" \
-e "USER=$USER" \
-p 127.0.0.1:28443:8080 
-v "/hancom/docker/code-server:/home/coder" \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/code-server
```
