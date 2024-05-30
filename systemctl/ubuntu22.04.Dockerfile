FROM ubuntu:22.04
# ENV 
# 컨테이너내 /proc/1/environ 에 저장

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# -qq : 오류를 제외하고는 출력되지 않음
RUN apt install -qq -y init systemd \
&& apt-get autoremove -y \
&& rm -rf /var/lib/{apt,dpkg,cache,log}

#
# Locale 설정
#
# 우분투는 기본적으로 C, C.UTF-8, POSIX 만 설치되어 있으며
# 기본적으로 POSIX로 설정되어 있어 한글이 깨진다.
# 로케일을 C.UTF-8로 설정 하던지 
# ENV LANG=C.UTF-8
# ko_KR.UTF-8, en_US.UTF-8 등은 직접 설치 해줘야 한다.
# 언어 설정 (LC_ALL > 나머지 카테고리 > LANG)
# 한국어 로케일 설정
RUN apt-get install -y locales \
&& localedef -i ko_KR -f UTF-8 ko_KR.UTF-8 \
&& echo "LANG=ko_KR.UTF-8" > /etc/default/locale
ENV LANG ko_KR.UTF-8

CMD ["/sbin/init"]