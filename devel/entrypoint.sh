#!/usr/bin/env bash

_PATH=$(dirname "$0")
echo "_PATH=${_PATH}, UNAME=${UNAME}, UID=$(id ${UNAME} -u), GID=$(id ${UNAME} -g), PUID=${PUID}, PGID=${PGID}"
sudo /usr/local/bin//user-mapping.sh ${UNAME} ${PUID} ${PGID}

# 스크립트가 실행될 때 받은 모든 인수를 그대로 다른 프로세스로 실행
exec "$@"
