#!/bin/bash
APP_NAME="use-sdk"
# move to project folder
cd ~/projects/${APP_NAME}
# remove package-lock.json
rm -rf package-lock.json   
rm -rf yarn.lock
git pull
# copy to .env path folder
# send deploy start message to teams using synology webhook
curl -X POST 'https://illunex.synology.me:52582/webapi/entry.cgi?api=SYNO.Chat.External&method=incoming&version=2&token=%22Zc07ZI3Qhn32kgMaDa8ACvyINlcNzy2X6RNAIJIdaNaVHR2LkLv9PSE2V5c98Kbk%22' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-d 'payload={"text":"@channel [NTBot] ('${APP_NAME}-web') 배포 시작"}'
# build-docker.sh execute
/bin/bash build-docker.sh
