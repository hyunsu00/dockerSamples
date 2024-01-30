# react.Dockerfile.BUILD.md

```bash
# 도커 이미지 빌드
$ docker build . -t sample.react:latest -f ./react.Dockerfile
# 컨테이너 실행
$ docker run -d --name=sample.react -p 8101:8101 sample.react
```