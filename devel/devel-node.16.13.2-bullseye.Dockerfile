FROM node:16.13.2-bullseye

ARG docker_build_files=./docker-build-files
ARG DEBIAN_FRONTEND=noninteractive
ARG UNAME=node

# 패키지 업데이트 및 sudo 지원 추가
# sudo /usr/local/bin 디폴트 경로 추가
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# fixuid 설치
RUN apt install -qq -y --no-install-recommends ca-certificates curl && \
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
RUN sudo apt clean && sudo apt autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
    
# 포트 노출
EXPOSE 3000

#
# 유틸리티 설치
#
RUN sudo apt install -qq -y --no-install-recommends dumb-init

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ${docker_build_files}/entrypoint.sh /usr/bin/entrypoint.sh
RUN sudo chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# 컨테이너가 켜지자마자 실행할 명령어 
CMD ["sleep", "infinity"]