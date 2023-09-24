FROM ubuntu:22.04

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

# 패키지 업데이트 및 sudo 지원 추가
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils sudo

RUN apt install -qq -y init systemd

# openjdk 11 설치
RUN apt-get install -y openjdk-11-jdk
# mvn 3.6.3 설치
RUN apt-get install -y maven
#
RUN apt-get install -y tomcat9

# 파일의 텍스트 변경
# sed -i s/이전문자열/변경문자열/g /디렉토리위치/파일명
RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

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

# #
# # 유저 생성
# #
# # 빌드시점 UNAME, UID, GID 설정
# ARG UNAME=devUser
# ARG UID=1000
# ARG GID=$UID
# # 유저 생성
# RUN groupadd --gid $GID $UNAME \
#     && useradd --uid $UID --gid $GID -m $UNAME \
#     && echo $UNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$UNAME \
#     && chmod 0440 /etc/sudoers.d/$UNAME
# # 작업디렉토리설정
# WORKDIR /home/$UNAME
# # 유저로 로그인
# USER $UNAME

# -qq : 오류를 제외하고는 출력되지 않음
RUN sudo apt-get autoremove -y \
&& sudo rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/sbin/init"]