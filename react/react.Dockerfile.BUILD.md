# react.Dockerfile.BUILD.md

```bash
$ docker build . -t sample.react:latest -f ./react.Dockerfile
$ docker run -d --name=sample.react -p 8101:8101 sample.react
```