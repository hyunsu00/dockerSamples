#!/usr/bin/env bash
_UNAME=$1;_PUID=$2; _PGID=$3
if [ -z "${_UNAME}" ]; then
    # ${_UNAME}, ${_UID}, ${_GID} 이 설정되어 있지 않으면 무시한다.
    echo "We need _UNAME, _UID, _GID to be set!"
elif [ -z "${_PUID}" -a -z "${_PGID}" ]; then
    # ${_PUID}, ${_PGID} 둘다 설정되지 않은 경우 아무것도 할 필요가 없다.
    echo "Nothing to do here."
else
    _UID=$(id ${_UNAME} -u);
    _GID=$(id ${_UNAME} -g);

    # ${_PUID}와 ${_PGID} 변수의 값이 설정되어 있지 않을 경우 기본값으로 ${UID}와 ${GID} 변수의 값을 사용
    _CUID=${_PUID:=$_UID}; 
    _CGID=${_PGID:=$_GID}

    if [ "${_CUID}" != "${_UID}" ] || [ "${_CGID}" != "${_GID}" ]; then
        # /etc/passwd에서 ${_UNAME}과 일치하는 행 찾음
        LINE=$(grep -F "${_UNAME}" /etc/passwd)
        # 모든 ':'을 공백으로 바꾸고 배열을 만든다.
        array=(${LINE//:/ })

        # 홈디렉토리는 배열의 5번째 요소
        _USER_HOME=${array[4]}

        # ${_UNAME}의 uid, gid 변경
        sed -i -e "s/^${_UNAME}:\([^:]*\):[0-9]*:[0-9]*/${_UNAME}:\1:${_CUID}:${_CGID}/" /etc/passwd
        sed -i -e "s/^${_UNAME}:\([^:]*\):[0-9]*/${_UNAME}:\1:${_CGID}/" /etc/group

        # 홈디렉토리를 변경된 uid, gid로 변경
        chown -R ${_CUID}:${_CGID} ${_USER_HOME}
    else
        # 변경된것이 없으므로 아무것도 할 필요가 없다.
        echo "Nothing to do here."
    fi
fi