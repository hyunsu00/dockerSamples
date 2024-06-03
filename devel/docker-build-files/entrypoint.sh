#!/usr/bin/env bash
set -eu

INITIALIZED_FILE="/tmp/initialized"
# 초기화 완료 상태 파일 제거
if [ -f "$INITIALIZED_FILE" ]; then
  rm -f "$INITIALIZED_FILE"
fi

echo 'begin : $(fixuid -q) ...'
{
  # 사용자 이름을 바꿀 때 sudo가 아래에서 작동하는지 확인하기 위해 먼저 이 작업을 수행합니다.
  # 그렇지 않으면 현재 컨테이너 UID가 passwd 데이터베이스에 존재하지 않을 수 있습니다.
  eval "$(fixuid -q)"
}
echo 'end : $(fixuid -q)'
echo "\$USER=$USER, \$UNAME=$UNAME, \$(whoami)=$(whoami)"

if [ "${USER-}" ]; then
  if [ "$USER" != "$(whoami)" ]; then
    echo "\$USER=$USER, \$(whoami)=$(whoami) is different"
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/nopasswd >/dev/null
    # 안타깝게도 바인드 마운트를 이동할 수 없으므로 $HOME을 변경할 수 없습니다.
    # 권한 있는 컨테이너가 필요하므로 마운트 $HOME을 새 홈에 바인딩할 수도 없습니다.
    sudo usermod --login "$USER" $UNAME
    sudo groupmod -n "$USER" $UNAME

    sudo sed -i "/$UNAME/d" /etc/sudoers.d/nopasswd
  else
    echo "\$USER=$USER, \$(whoami)=$(whoami) is the same"
  fi
fi

# 작업 영역을 준비하기 위해 사용자가 컨테이너 시작 시 스크립트를 실행하도록 허용합니다.
# https://github.com/coder/code-server/issues/5177
if [ -d "${ENTRYPOINTD}" ]; then
  find "${ENTRYPOINTD}" -type f -executable -print -exec {} \;
fi

# 초기화 완료 상태 파일 생성
touch "$INITIALIZED_FILE"

exec dumb-init "$@"
