FROM ubuntu:22.04

ARG docker_build_files=./docker-build-files

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# 패키지 목록 업데이트
RUN apt-get update

# systemctl 설치
RUN apt-get install -qq -y --no-install-recommends init systemd 

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

# 개발툴 설치 (Development Tools)
# 이곳에 개발툴을 설치합니다.

#
# 유저 생성
#
# 빌드시점 UNAME, UID, GID 설정
ARG UNAME=devuser
ARG UID=1000
ARG GID=$UID

# 유저 생성
RUN groupadd --gid $GID $UNAME && \
    useradd --uid $UID --gid $GID -m $UNAME && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# fixuid 설치
RUN apt-get install -qq -y --no-install-recommends ca-certificates curl && \
    ARCH="$(dpkg --print-architecture)" && \
    curl -fsSL https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-$ARCH.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $UNAME\ngroup: $UNAME\n" > /etc/fixuid/config.yml

# 작업 영역을 준비하기 위해 사용자가 컨테이너 시작 시 스크립트를 실행하도록 허용합니다.
# https://github.com/coder/code-server/issues/5177
ENV ENTRYPOINTD=${HOME}/entrypoint.d

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME

# 패키지 캐쉬 정리 및 사용되지 않는 패키지 삭제 및 설치시 사용된 데이터 삭제
RUN sudo apt-get clean && sudo apt-get autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

#
# wsl
#
COPY ${docker_build_files}/wsl.conf /etc/wsl.conf
RUN sudo sed -i "s/default=\$UNAME/default=$UNAME/" /etc/wsl.conf
RUN sudo sed -i "s/\(${UNAME}:.*:\)\/bin\/sh/\1\/bin\/bash/" /etc/passwd
                
#
# 유틸리티 설치
#
RUN sudo apt-get install -qq -y --no-install-recommends dumb-init

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
ENV USER=$UNAME
COPY ${docker_build_files}/entrypoint.sh /usr/bin/entrypoint.sh
RUN sudo chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["sleep", "infinity"]
