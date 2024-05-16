FROM ubuntu:22.04

# 빌드중에만(ARG) 사용자 입력을 요구하는 것을 방지하는 설정
ARG DEBIAN_FRONTEND=noninteractive

# 패키지 업데이트 및 sudo 지원 추가
RUN apt update && apt install -qq --no-install-recommends -y sudo && \
    sed -i 's/\(Defaults\s*secure_path="[^"]*\)/\1:\/usr\/local\/bin/' /etc/sudoers

RUN apt install -qq --no-install-recommends -y locales \
&& localedef -i ko_KR -f UTF-8 ko_KR.UTF-8 \
&& echo "LANG=ko_KR.UTF-8" > /etc/default/locale
ENV LANG ko_KR.UTF-8

RUN  apt install -qq --no-install-recommends -y gcc g++ make git

COPY ./Python-3.7.10.tgz /tmp/Python-3.7.10.tgz
RUN apt install -qq --no-install-recommends -y libssl-dev \
    libncursesw5-dev libsqlite3-dev libgdbm-dev libreadline-dev \
    zlib1g-dev libbz2-dev libffi-dev tk-dev	 
# RUN cd /tmp/ && \
#     tar -zxvf Python-3.7.10.tgz && \
#     cd Python-3.7.10 && \
#     ./configure --enable-optimizations --without-headers --without-libs --disable-ipv6 && \
#     make altinstall && \
#     cd ../ && \
#     rm -rf Python-3.7.10 && \
#     rm -f Python-3.7.10.tgz && \
#     /usr/local/bin/pip3.7 install pyminifier

CMD ["sleep", "infinity"]