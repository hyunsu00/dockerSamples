!/usr/bin/env bash

printf "컨테이너 초기화 중"
while ! test -f /tmp/initialized; do
  printf "."
  sleep 5
done

