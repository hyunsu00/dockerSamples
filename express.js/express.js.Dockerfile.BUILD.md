# express.js.Dockerfile.BUILD.md

```bash
$ docker build . -t sample.express.js:latest -f ./express.js.Dockerfile
$ docker run -d --name=sample.express.js -p 3000:3000 sample.express.js
```