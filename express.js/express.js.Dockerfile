FROM node:16.13.2-alpine

# 작업 디렉토리 설정
WORKDIR /app

# npm install 을 위해, package.json과 package-lock.json을 먼저 copy해둠
COPY ./app/package*.json /app/

# express.js 패키지 설치
RUN npm install

# express.js app 복사
COPY ./app /app

# 포트 노출
EXPOSE 3000

# 컨테이너가 켜지자마자 실행할 명령어 
# npm start : package.json의 scripts에 있는 start 명령어를 실행
CMD ["npm", "start"]