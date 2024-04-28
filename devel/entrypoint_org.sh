#!/bin/bash

# ${UNAME}이 설정되어 있지 않으면 무시한다.
if [ -z "${UNAME}" ]; then
  echo "We need USER to be set!"; exit 100
fi

# ${PUID}, ${PGID} 둘다 설정되지 않은 경우 아무것도 할 필요가 없다.
if [ -z "${PUID}" -a -z "${PGID}" ]; then
    echo "Nothing to do here."; exit 0
fi

# ${PUID}와 ${PGID} 변수의 값이 설정되어 있지 않을 경우 기본값으로 ${UID}와 ${GID} 변수의 값을 사용
UID=${PUID:=$UID}
GID=${PGID:=$GID}

# /etc/passwd엣 ${UNAME}과 일치하는 행 찾음
LINE=$(grep -F "${UNAME}" /etc/passwd)
# 모든 ':'을 공백으로 바꾸고 배열을 만든다.
array=(${LINE//:/ })

# 홈디렉토리는 배열의 5번째 요소
USER_HOME=${array[4]}

# ${UNAME}의 uid, gid 변경
sed -i -e "s/^${UNAME}:\([^:]*\):[0-9]*:[0-9]*/${UNAME}:\1:${UID}:${GID}/" /etc/passwd
sed -i -e "s/^${UNAME}:\([^:]*\):[0-9]*/${UNAME}:\1:${GID}/" /etc/group

# 홈디렉토리를 변경된 uid, gid로 변경
chown -R ${UID}:${GID} ${USER_HOME}

# exec su - "${UNAME}"

set -- gosu ${UNAME} "$@"
exec "$@"