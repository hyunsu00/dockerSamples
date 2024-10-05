FROM centos:7

# centos7 EOL repository fix
RUN cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/AtlasGondal/centos7-eol-repo-fix/main/CentOS-Base.repo && \
    yum clean all && \
    yum makecache && \
    yum update -y

# 타임존 설정
ENV TZ=Asia/Seoul

# Locale 설정
RUN localedef -i ko_KR -f UTF-8 ko_KR.utf8 && \
    echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# sudo 지원 및 sudo /usr/local/bin 디폴트 경로 추가
RUN yum install -y sudo && \
    sed -i -r -e '/^\s*Defaults\s+secure_path/ s[=(.*)[=\1:/usr/local/bin[' /etc/sudoers

# yum 패키지 매니저 캐시 정리
RUN sudo yum clean all

#
# 유저 생성
#
# 빌드시점 UNAME, UID, GID 설정
ARG UNAME=installpro
ARG UID=1000
ARG GID=$UID

# 유저 생성
RUN groupadd --gid $GID $UNAME && \
    useradd --uid $UID --gid $GID -m $UNAME && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME
