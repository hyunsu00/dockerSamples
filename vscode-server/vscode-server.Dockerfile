FROM ubuntu:22.04

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# 패키지 목록 업데이트, systemctl 설치
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends apt-utils init systemd

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

# 유저 생성
RUN adduser --gecos '' --disabled-password coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# fixuid 설치
RUN apt-get install -qq -y --no-install-recommends ca-certificates curl && \
    ARCH="$(dpkg --print-architecture)" && \
    curl -fsSL https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-$ARCH.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml
#
# vscode-server 설치 및 세팅
#
# Add the Microsoft GPG key
RUN apt-get install -qq -y --no-install-recommends wget gpg && \
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg
# Add the Visual Studio Code repository
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list
# install vscode-server
RUN apt-get update && apt-get install -qq -y --no-install-recommends code

# 작업 영역을 준비하기 위해 사용자가 컨테이너 시작 시 스크립트를 실행하도록 허용합니다.
# https://github.com/coder/code-server/issues/5177
ENV ENTRYPOINTD=${HOME}/entrypoint.d

# 필요한 유틸리티 설치
RUN apt-get install -qq -y --no-install-recommends dumb-init \
    git \
    git-lfs \
    htop \
    lsb-release \
    man-db \
    nano \
    openssh-client \
    procps \
    vim-tiny \
    zsh && \ 
    git lfs install
# 패키지 캐쉬 정리 및 사용되지 않는 패키지 삭제 및 설치시 사용된 데이터 삭제
RUN apt-get clean && apt-get autoremove && rm -rf /var/lib/{apt,dpkg,cache,log}

EXPOSE 8585
# 이렇게 하면 누군가 $DOCKER_USER를 설정하면 uid가 동일하게 유지되므로 docker-exec가 계속 작동합니다.
# 참고: -u가 docker-run에 전달되지 않은 경우에만 관련됩니다.
USER 1000
ENV USER=coder
WORKDIR /home/coder

# 호스트의 uid, gid 맵핑
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN sudo chmod +x /usr/bin/entrypoint.sh
ENV DONT_PROMPT_WSL_INSTALL=YES 
ENTRYPOINT ["/usr/bin/entrypoint.sh", "serve-web", "--host", "0.0.0.0", "--port", "8585", "--user-data-dir", "/home/coder", "--connection-token", "semtl"]
