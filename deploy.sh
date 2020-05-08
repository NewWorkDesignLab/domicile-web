#!/usr/bin/env sh
set -e

HOST="root@134.122.84.237"
DEPLOY_TO="/var/www/domicile.tobiasbohn.com"
RELEASE="domicile_release_001"
RELEASE_PATH="${DEPLOY_TO}/releases/${RELEASE}"
MASTER_KEY=$(cat config/master.key)
POSTGRES_USER=$(grep POSTGRES_USER .env | xargs)
POSTGRES_PASSWORD=$(grep POSTGRES_PASSWORD .env | xargs)

echo "Building App Image"
DOCKER_BUILDKIT=1 docker build . -t domicile_web:prod --target production --build-arg RAILS_MASTER_KEY=$MASTER_KEY

echo "Save App Image and Compress"
docker save domicile_web:prod | gzip > /tmp/domicile_web_prod.tar

echo "Preparing SSH Deploy Directory"
ssh $HOST mkdir -p $RELEASE_PATH

echo "Copy App Image"
scp /tmp/domicile_web_prod.tar $HOST:$RELEASE_PATH

echo "Copy Docker-Compose Files"
scp ./docker-compose.yml $HOST:$RELEASE_PATH
scp ./docker-compose.production.yml $HOST:$RELEASE_PATH

echo "Load Docker Image"
ssh $HOST "docker image load -q -i ${RELEASE_PATH}/domicile_web_prod.tar"

echo "Starting Docker"
ssh $HOST "RAILS_MASTER_KEY=${MASTER_KEY} ${POSTGRES_USER} ${POSTGRES_PASSWORD} docker-compose -f ${RELEASE_PATH}/docker-compose.yml -f ${RELEASE_PATH}/docker-compose.production.yml up -d -V"
