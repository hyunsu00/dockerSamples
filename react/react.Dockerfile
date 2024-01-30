FROM node:16.13.2-alpine

# 작업 디렉토리 설정
WORKDIR /app

# serve 웹서버 설치
RUN npm install -g serve

# react 빌드앱 복사
COPY ./app/build /app

# 포트 노출
EXPOSE 8101

# 컨테이너가 켜지자마자 실행할 명령어 
# serve -l 8101 -s ./ 실행
CMD ["serve", "-l", "8101", "-s",  "./"]