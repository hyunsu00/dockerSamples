FROM rockylinux:8.8

# 패키지 업데이트 및 sudo 지원 추가
RUN yum update -y && yum clean all && yum install -y sudo

# Locale 설정
RUN yum install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# EPEL Repository 설치
RUN yum install -y dnf-plugins-core \
    epel-release

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
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME

ENV UNAME=$UNAME
ENV UID=$UID
ENV GID=$GID
# USER root
COPY ./_entrypoint.sh /
RUN  sudo chmod u+x /_entrypoint.sh
COPY ./entrypoint.sh /
RUN  sudo chmod u+x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]