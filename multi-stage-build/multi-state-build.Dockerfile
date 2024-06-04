FROM centos:7 as builder

ARG PYTHON_VERSION=3.11.5
ARG OPENSSL_VERSION=1.1.1w
ARG OPENSSL_SHA256=cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8

RUN yum install -y epel-release
RUN yum install -y ncurses-devel bzip2-devel gdbm-devel xz-devel zlib-devel \
    libuuid-devel readline-devel sqlite-devel libffi-devel \
    gcc make automake perl-core pkgconfig nasm curl
                    
# For unknown reason, build process wouldn't pick up openssl11-devel package
# when prefix is set.
# I have to build my own OpenSSL here.

# Also, the certificate for www.openssl.org cannot be verified by
# curl or wget for some reason.
RUN source /etc/os-release && curl -Ok https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz && \
    if echo "${OPENSSL_SHA256}  openssl-${OPENSSL_VERSION}.tar.gz" | sha256sum -c; then \
        tar xvf openssl-${OPENSSL_VERSION}.tar.gz && \
        cd openssl-${OPENSSL_VERSION} && \
        ./config --prefix=/opt/python/${PYTHON_VERSION}-el${VERSION_ID}.$(uname -m) --openssldir=/opt/python/${PYTHON_VERSION}-el${VERSION_ID}.$(uname -m) && \
        make -j$(nproc) && \
        make install_sw && \
        cd .. && \
        rm -rf openssl-${OPENSSL_VERSION} openssl-${OPENSSL_VERSION}.tar.gz; \
    else \
        echo "SHA256 check failed" && exit 1; \
    fi

# Build Python
RUN source /etc/os-release && curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xvf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure \
        --enable-loadable-sqlite-extensions \
        --prefix=/opt/python/${PYTHON_VERSION}-el${VERSION_ID}.$(uname -m) \
        --with-openssl=/opt/python/${PYTHON_VERSION}-el${VERSION_ID}.$(uname -m) \
        --with-openssl-rpath=auto && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf Python-${PYTHON_VERSION} Python-${PYTHON_VERSION}.tgz

FROM centos:7

COPY --from=builder /opt/python/3.11.5-el7.x86_64 /opt/python/3.11.5-el7.x86_64

# Add Python to PATH
ENV PATH=/opt/python/3.11.5-el7.x86_64/bin:$PATH
# Add Python shared library to LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/opt/python/3.11.5-el7.x86_64/lib:$LD_LIBRARY_PATH

CMD ["tail", "-f", "/dev/null"]
