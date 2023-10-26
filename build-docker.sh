#!/bin/bash
APP_NAME="use-sdk"
VERSION="1.0.0"
PORT="20066"
NETWORK="database-network"
APP_NAME_OLD="${APP_NAME}-old"


#################################################################################
# 배포 순서
# 1. docker rename 명령어로 컨테이너 이름을 바꾼다.
# 2. docker tag 명령어로 이미지 이름을 바꾼다.
# 3. yarn 명령어로 Dependencies 를 설치한다.
# 4. yarn 명령어로 빌드한다.
# 5. docker build 명령어로 이미지를 생성한다.
# 6. docker stop 명령어로 1번에서 바꾼 이름으로된 컨테이너를 중지시킨다.
# 7. docker rm 명령어로 6번에서 중지시킨 컨테이너를 삭제한다.
# 8. docker rmi 명령어로 2번에서 바꾼 이름으로된 이미지를 삭제한다.
# 9. docker run 명령어로 5번에서 생성한 이미지로 컨테이너를 구동한다.
# 10. 시놀로지 웹훅을 이용해 배포가 끝났음을 알린다.
#################################################################################

# 1. Change the current docker container name to old
echo "---------- [Deploy Step - 1] : Rename Current Docker Container"
docker rename ${APP_NAME} ${APP_NAME_OLD}
# 2. Change the current docker images name to old
echo "---------- [Deploy Step - 2] : Rename Current Docker Image"
docker tag ${APP_NAME}:${VERSION} ${APP_NAME_OLD}:${VERSION}
# 3. Install the Dependencies using yarn
echo "---------- [Deploy Step - 3] : Yarn install"
yarn
# 4. Build the react using yarn
yarn build
# 5. Build the docker image
echo "---------- [Deploy Step - 4] : Build New Docker Image"
docker build -t ${APP_NAME}:${VERSION} .
# 6. Stop the old docker container
echo "---------- [Deploy Step - 5] : Stop Old Docker Container"
docker stop ${APP_NAME_OLD}
# 7. Remove the old docker container
echo "---------- [Deploy Step - 6] : Remove Old Docker Container"
docker rm ${APP_NAME_OLD}
# 8. Remove the old docker image
echo "---------- [Deploy Step - 7] : Remove Old Docker Image"
docker rmi ${APP_NAME_OLD}:${VERSION}
# 9. Run new docker container
echo "---------- [Deploy Step - 8] : Run New Docker Container"
docker run -d -p ${PORT}:80 \
  -v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
  --restart unless-stopped \
  --network ${NETWORK} \
  --name ${APP_NAME} \
  ${APP_NAME}:${VERSION}
# 10. send deploy end message to teams using synology webhook
curl -X POST 'https://illunex.synology.me:52582/webapi/entry.cgi?api=SYNO.Chat.External&method=incoming&version=2&token=%22Zc07ZI3Qhn32kgMaDa8ACvyINlcNzy2X6RNAIJIdaNaVHR2LkLv9PSE2V5c98Kbk%22' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'payload={"text":"@channel [NTBot] ('${APP_NAME}-web') 배포 완료"}'