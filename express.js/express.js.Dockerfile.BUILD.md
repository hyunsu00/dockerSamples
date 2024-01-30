# express.js.Dockerfile.BUILD.md

```bash
# 도커 이미지 빌드
$ docker build . -t sample.express.js:latest -f ./express.js.Dockerfile
# 컨테이너 실행
$ docker run -d --name=sample.express.js -p 3000:3000 sample.express.js
```