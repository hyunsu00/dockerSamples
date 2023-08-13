FROM ubuntu:22.04

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# 파일의 텍스트 변경
# sed -i s/이전문자열/변경문자열/g /디렉토리위치/파일명
RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

# -qq : 오류를 제외하고는 출력되지 않음
RUN apt update \
  && apt install -qq -y init systemd \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/sbin/init"]