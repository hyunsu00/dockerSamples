FROM redhat/ubi8:8.6

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

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y make
RUN yum install -y git

RUN yum install -y openssl-devel
RUN yum install -y fontconfig-devel
RUN yum install -y libcurl-devel
RUN yum install -y libX11-devel 

# RUN yum install -y cairo-devel
# RUN yum install -y harfbuzz-devel
# RUN yum install -y ImageMagick-devel
# RUN yum install -y mesa-libGLU-devel

RUN yum install -y xerces-c-devel.x86_64
RUN yum install -y log4cxx-devel

# RUN yum install -y libarchive-devel

RUN yum install -y python2
RUN yum install -y python3.11-devel
RUN yum install -y python3.11-pip

RUN yum install -y https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

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

RUN sudo yum install -y nss \
    nspr \
    atk \
    cups-libs \
    libdrm \
    at-spi2-atk \
    libXcomposite \
    libXdamage \
    libXext \
    libXfixes \
    libXrandr \
    mesa-libgbm \
    libxkbcommon \
    pango \
    cairo \
    alsa-lib
RUN python3 -m pip install playwright
RUN python3 -m playwright install chromium


# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ./entrypoint.sh /
COPY ./user-mapping.sh /usr/local/bin/
RUN sudo chmod +x /entrypoint.sh && \
    sudo chmod +x /usr/local/bin/user-mapping.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["sleep", "infinity"]