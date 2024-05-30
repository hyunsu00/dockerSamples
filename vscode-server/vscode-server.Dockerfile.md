# fixuid.md

## docker build

```bash
# hyunsu00/vscode-server 빌드
$ docker build \
-t hyunsu00/vscode-server \
-f ./vscode-server.Dockerfile .
```

## docker push

```bash
# 도커 허브 로그인
$ docker login -u hyunsu00
Password: dckr_pat_rQMyLeZiSbgrcYpVbCm11tEZR7Q

# docker.io/hyunsu00/vscode-server 저장소 push
$ docker push hyunsu00/vscode-server
```

## docker pull

```bash
# docker.io/hyunsu00/vscode-server 저장소 pull
$ docker pull hyunsu00/vscode-server
```

## docker run

```bash
# vscode-server 실행
$ docker run -d --name vscode-server \
-u $(id -u):$(id -g) \
-p 28585:8585 \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
hyunsu00/vscode-server

$ docker run -it --name vscode-server -p 28585:8585 \
-v "/hancom/docker/vscode-server:/home/coder" \
-v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
-u "$(id -u):$(id -g)" \
-e "DOCKER_USER=$USER" \
hyunsu00/vscode-server
```
