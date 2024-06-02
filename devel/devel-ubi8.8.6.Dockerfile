FROM redhat/ubi8:8.6

ARG docker_build_files=./docker-build-files

# 패키지 목록 업데이트
RUN dnf makecache

# 타임존 설정
ENV TZ=Asia/Seoul

# Locale 설정
RUN dnf install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# sudo 지원 및 sudo /usr/local/bin 디폴트 경로 추가
RUN dnf install -y sudo && \
    sed -i -r -e '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' /etc/sudoers

# EPEL Repository 설치
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

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
RUN ARCH="$(uname -m | sed 's/x86_64/amd64/g' | sed 's/aarch64/arm64/g')" && \
    curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - && \
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

# dnf 패키지 매니저 캐시 정리
RUN sudo dnf clean all

#
# wsl
#
COPY ${docker_build_files}/wsl.conf /etc/wsl.conf
RUN sudo sed -i "s/default=\$UNAME/default=$UNAME/" /etc/wsl.conf
RUN sudo ln -sf /etc/locale.conf /etc/default/locale

# 유틸리티 설치
RUN sudo dnf install -y ncurses wget dumb-init

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ${docker_build_files}/entrypoint.sh /usr/bin/entrypoint.sh
RUN sudo chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["sleep", "infinity"]