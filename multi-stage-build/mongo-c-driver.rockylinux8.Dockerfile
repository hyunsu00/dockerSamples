#
# 1단계: mongo-c-driver 빌드
#
FROM rockylinux:8 AS builder

# 환경 변수 설정
ENV MONGO_C_DRIVER_VERSION 1.17.0

# 개발 도구 설치
RUN dnf groupinstall -y "Development Tools" && \
    dnf install -y cmake \
    openssl-devel \
    cyrus-sasl-devel \
    zlib-devel \
    ca-certificates \
    patch \
    wget
    
# mongo-c-driver 소스 다운로드 및 압축 해제
WORKDIR /tmp
RUN wget https://github.com/mongodb/mongo-c-driver/releases/download/${MONGO_C_DRIVER_VERSION}/mongo-c-driver-${MONGO_C_DRIVER_VERSION}.tar.gz
RUN tar -xzvf mongo-c-driver-${MONGO_C_DRIVER_VERSION}.tar.gz

# mongo-c-driver 빌드
WORKDIR /tmp/mongo-c-driver-${MONGO_C_DRIVER_VERSION}
ENV MONGO_C_DRIVER_INSTALL_PREFIX=/tmp/builder/mongo-c-driver/dist
RUN mkdir cmake-build && cd cmake-build && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${MONGO_C_DRIVER_INSTALL_PREFIX} .. && \
    make -j "$(nproc)" && \
    make install

#
# 2단계: 필요한 런타임 종속성만 포함된 최종 이미지 생성
#
FROM rockylinux:8

# 빌더 단계에서 빌드된 mongo-c-driver 복사
COPY --from=builder /tmp/builder/mongo-c-driver/dist /usr/local
