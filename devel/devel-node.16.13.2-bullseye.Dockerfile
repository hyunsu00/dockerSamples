FROM node:16.13.2-bullseye

ARG docker_build_files=./docker-build-files
ARG UNAME=node
ARG DEBIAN_FRONTEND=noninteractive

# 패키지 업데이트 및 sudo 지원 추가
# sudo /usr/local/bin 디폴트 경로 추가
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 작업디렉토리설정
WORKDIR /home/$UNAME

# 기본 사용자 설정
USER $UNAME

# 포트 노출
EXPOSE 3000

# 호스트의 uid, gid 맵핑
ENV UNAME=$UNAME
COPY ${docker_build_files}/entrypoint.sh /
COPY ${docker_build_files}/user-mapping.sh /usr/local/bin/
RUN sudo chmod +x /entrypoint.sh && \
    sudo chmod +x /usr/local/bin/user-mapping.sh
ENTRYPOINT ["/entrypoint.sh"]

# 컨테이너가 켜지자마자 실행할 명령어 
CMD ["sleep", "infinity"]