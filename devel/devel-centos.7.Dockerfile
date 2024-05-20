FROM centos:7

ARG docker_build_files=./docker-build-files

# 패키지 목록 업데이트
RUN yum makecache

# 타임존 설정
ENV TZ=Asia/Seoul

# Locale 설정
RUN localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# sudo 지원 및 sudo /usr/local/bin 디폴트 경로 추가
RUN yum install -y sudo && \
    sed -i -r -e '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' /etc/sudoers

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
    echo $UNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$UNAME && \
    chmod 0440 /etc/sudoers.d/$UNAME

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME

# yum 패키지 매니저 캐시 정리
RUN sudo yum clean all

#
# wsl
#
COPY ${docker_build_files}/wsl.conf /etc/wsl.conf
RUN sudo sed -i "s/default=\$UNAME/default=$UNAME/" /etc/wsl.conf

#
# 유틸리티 설치
#
RUN sudo yum install -y ncurses wget

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ${docker_build_files}/entrypoint.sh /
COPY ${docker_build_files}/user-mapping.sh /usr/local/bin/
RUN sudo chmod +x /entrypoint.sh && \
    sudo chmod +x /usr/local/bin/user-mapping.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["sleep", "infinity"]