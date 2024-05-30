#!/usr/bin/env bash

# 인수로 받은 문자열을 명령어로 해석하고 실행
eval $(fixuid)

# 스크립트가 실행될 때 받은 모든 인수를 그대로 다른 프로세스로 실행
exec "$@"
