FROM redhat/ubi8:8.6
# ENV 
# 컨테이너내 /proc/1/environ 에 저장

# 패키지 업데이트 및 sudo, clear 지원 추가
RUN yum update -y && yum clean all && yum install -y sudo && yum install -y ncurses

#
#
# Locale 설정
#
# rhel8.6은 기본적으로 C, en_~, POSIX, C.UTF-8 만 설치되어 있으며
# 기본적으로 C.UTF-8로 설정되어 있어 한글 출력에는 이상이 없다.
# 그외 ko_KR.UTF-8 등은 직접 설치 해줘야 한다.
# 언어 설정 (LC_ALL > 나머지 카테고리 > LANG)
# 한국어 로케일 설정
RUN yum install -y glibc-locale-source \
&& localedef -i ko_KR -f UTF-8 ko_KR.utf8 \
&& echo "LANG=ko_KR.UTF-8" > /etc/locale.conf
ENV LANG ko_KR.utf8

CMD ["/sbin/init"]