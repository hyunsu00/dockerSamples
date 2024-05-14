FROM rockylinux:8.8

# 패키지 업데이트 및 sudo 지원 추가
RUN yum clean all && yum install -y sudo

# clear 커맨드 추가
RUN yum install -y ncurses

# Locale 설정
RUN yum install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# sudo /usr/local/bin 디퐆트 경로 추가
RUN sed -i -r -e \
    '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' \
    /etc/sudoers

RUN dnf groupinstall -y "Development Tools" && \
    dnf install -y cmake

#
# 유저 생성
#
# 빌드시점 UNAME, UID, GID 설정
ARG UNAME=hancom
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

CMD ["sleep", "infinity"]