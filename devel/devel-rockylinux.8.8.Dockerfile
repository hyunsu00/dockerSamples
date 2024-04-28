FROM rockylinux:8.8

# 패키지 업데이트 및 sudo 지원 추가
RUN yum update -y && yum clean all && yum install -y sudo

# Locale 설정
RUN yum install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

ENV GOSU_VERSION=1.17
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu

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
# WORKDIR /home/$UNAME

# 기본 사용자 설정
# USER $UNAME

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
ENV UID=$UID
ENV GID=$GID

COPY ./entrypoint_org.sh /
RUN  sudo chmod u+x /entrypoint_org.sh
COPY ./entrypoint.sh /
RUN  sudo chmod u+x /entrypoint.sh
COPY ./user-mapping.sh /
RUN  sudo chmod u+x /user-mapping.sh
ENTRYPOINT ["/entrypoint_org.sh"]

# CMD ["sleep", "infinity"]