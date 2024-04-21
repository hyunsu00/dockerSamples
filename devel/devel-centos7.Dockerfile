FROM centos:7
# ENV 
# 컨테이너내 /proc/1/environ 에 저장

# 패키지 업데이트 및 sudo 지원 추가
RUN yum update -y && yum clean all && yum install -y sudo

#
# Locale 설정
#
# centos7은 기본적으로 C, en_~, POSIX 만 설치되어 있으며
# 기본적으로 en_US.UTF-8로 설정되어 있어 한글 출력에는 이상이 없다.
# 그외 ko_KR.UTF-8 등은 직접 설치 해줘야 한다.
# 언어 설정 (LC_ALL > 나머지 카테고리 > LANG)
# 한국어 로케일 설정
RUN localedef -i ko_KR -f UTF-8 ko_KR.utf8 \
&& echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

# EPEL Repository 설치
RUN yum install -y dnf-plugins-core \
    epel-release

# 개발툴 설치
RUN yum groupinstall -y "Development Tools"

# python3 설치 (3.11.5)
RUN yum install -y openssl11-devel libffi-devel bzip2-devel && \
    curl -o /tmp/Python-3.11.5.tgz https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz && \
    cd /tmp/ && \
    tar -zxvf Python-3.11.5.tgz && \
    cd Python-3.11.5 && \
    export CFLAGS=$(pkg-config --cflags openssl11) && \
    export LDFLAGS=$(pkg-config --libs openssl11) && \
    ./configure && \
    make && \
    make install

#
# 유저 생성
#
# 빌드시점 UNAME, UID, GID 설정
ARG UNAME=devUser
ARG UID=1000
ARG GID=$UID

# 유저 생성
RUN groupadd --gid $GID $UNAME \
    && useradd --uid $UID --gid $GID -m $UNAME \
    && echo $UNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$UNAME \
    && chmod 0440 /etc/sudoers.d/$UNAME

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME

# playwright 설치 (centos7 기준 최종 playwright)
RUN python3 -m pip install playwright==1.30.0 && \
    python3 -m playwright install chromium
RUN sudo yum install -y atk \
    at-spi2-atk \
    libdrm \
    cups \
    libXcomposite \
    libxkbcommon \
    pango \
    alsa-lib

CMD ["sleep", "infinity"]