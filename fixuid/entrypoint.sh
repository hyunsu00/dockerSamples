#!/usr/bin/env bash
set -eu

# 인수로 받은 문자열을 명령어로 해석하고 실행
eval $(fixuid)

if [ "${USER-}" ]; then
  if [ "$USER" != "$(whoami)" ]; then
    echo "To resolve the discrepancy between \$USER and \$(whoami), we will change the login name to match \$USER."
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/nopasswd >/dev/null
    # 안타깝게도 바인드 마운트를 이동할 수 없으므로 $HOME을 변경할 수 없습니다.
    # 권한 있는 컨테이너가 필요하므로 마운트 $HOME을 새 홈에 바인딩할 수도 없습니다.
    sudo usermod --login "$USER" $UNAME
    sudo groupmod -n "$USER" $UNAME

    sudo sed -i "/$UNAME/d" /etc/sudoers.d/nopasswd

    echo "result : \$USER=$USER, \$UNAME=$UNAME, \$(whoami)=$(whoami)"
  else
    echo "\$USER=$USER, \$(whoami)=$(whoami) is the same"
  fi
fi

# 작업 영역을 준비하기 위해 사용자가 컨테이너 시작 시 스크립트를 실행하도록 허용합니다.
# https://github.com/coder/code-server/issues/5177
if [ -d "${ENTRYPOINTD}" ]; then
  find "${ENTRYPOINTD}" -type f -executable -print -exec {} \;
fi

# 스크립트가 실행될 때 받은 모든 인수를 그대로 다른 프로세스로 실행
exec "$@"
