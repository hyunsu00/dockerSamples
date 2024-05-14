FROM redhat/ubi9:9.2

# dnf 패키지 매니저 캐시 정리
RUN dnf clean all

# sudo 지원 및 sudo /usr/local/bin 디폴트 경로 추가
RUN dnf install -y sudo && \
    sed -i -r -e \
    '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' \
    /etc/sudoers

# 유틸리티 설치 (clear 명령어)
RUN dnf install -y ncurses

# Locale 설정
RUN dnf install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# EPEL Repository 설치
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# python3.11, python3.11-pip 설치 및 python, python3 기본버전은 python3.11로 실행
RUN dnf install -y python3.11 python3.11-pip
RUN alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 && \
    alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2 && \
    alternatives --set python3 /usr/bin/python3.11 && \
    alternatives --install /usr/bin/python python /usr/bin/python3.9 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3.11 2 && \
    alternatives --set python /usr/bin/python3.11 && \
    sed -i 's|#!/usr/bin/python3|#!/usr/bin/python3.9|g' /usr/bin/dnf && \
    sed -i 's|#!/usr/bin/python3|#!/usr/bin/python3.9|g' /usr/bin/yum

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

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ./entrypoint.sh /
COPY ./user-mapping.sh /usr/local/bin/
RUN sudo chmod +x /entrypoint.sh && \
    sudo chmod +x /usr/local/bin/user-mapping.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["sleep", "infinity"]