FROM ubuntu:22.04

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# 패키지 목록 업데이트
RUN apt-get update

# systemctl 설치
RUN apt-get install -qq -y --no-install-recommends apt-utils init systemd 

# 타임존 설정
ENV TZ=Asia/Seoul
RUN apt-get install -qq -y --no-install-recommends tzdata

# Locale 설정
RUN apt-get install -qq -y --no-install-recommends locales && \
    localedef -i ko_KR -f UTF-8 ko_KR.UTF-8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/default/locale
ENV LANG ko_KR.UTF-8

# sudo 지원 및 sudo /usr/local/bin 디폴트 경로 추가
RUN apt-get install -qq -y --no-install-recommends sudo && \
    sed -i 's/\(Defaults\s*secure_path="[^"]*\)/\1:\/usr\/local\/bin/' /etc/sudoers

# 패키지 캐쉬 정리 및 사용되지 않는 패키지 삭제 및 설치시 사용된 데이터 삭제
RUN sudo apt-get clean && sudo apt-get autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
#
# 유저 생성
#
# 빌드시점 UNAME, UID, GID 설정
ARG UNAME=installpro
ARG UID=1000
ARG GID=$UID

# 유저 생성
RUN groupadd --gid $GID $UNAME && \
    useradd --uid $UID --gid $GID -m $UNAME && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME
