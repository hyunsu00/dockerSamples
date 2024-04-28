FROM rockylinux:8.8

# 패키지 업데이트 및 sudo 지원 추가
RUN yum update -y && yum clean all && yum install -y sudo

# clear 커맨드 추가
RUN yum install ncurses

# Locale 설정
RUN yum install -y glibc-locale-source && \
    localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# sudo /usr/local/bin 디퐆트 경로 추가
RUN sed -i -r -e \
    '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' \
    /etc/sudoers

# gosu 추가   
ENV GOSU_VERSION=1.17
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu

#
# frontend 설치 (v16.13.2)
#
COPY ./node-v16.13.2-linux-x64.tar.xz /tmp/
RUN cd /tmp/ && \
    tar -xvf node-v16.13.2-linux-x64.tar.xz && \
    cd ./node-v16.13.2-linux-x64/ && \
    cp -rf ./* /usr/local/ && \
    cd .. && \
    rm -rf ./node-v16.13.2-linux-x64/ && \
    rm -f node-v16.13.2-linux-x64.tar.xz

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

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ./entrypoint.sh /
COPY ./user-mapping.sh /usr/local/bin/
RUN sudo chmod +x /entrypoint.sh && \
    sudo chmod +x /usr/local/bin/user-mapping.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["sleep", "infinity"]