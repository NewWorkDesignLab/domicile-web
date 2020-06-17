#!/usr/bin/env sh
set -e

HOST="root@134.122.84.237"
DEPLOY_TO="/var/www/domicile.tobiasbohn.com"
RELEASE="domicile_release_${1}"
RELEASE_PATH="${DEPLOY_TO}/releases/${RELEASE}"
MASTER_KEY=$(cat config/master.key)
POSTGRES_USER=$(grep POSTGRES_USER .env | xargs)
POSTGRES_PASSWORD=$(grep POSTGRES_PASSWORD .env | xargs)

COMPOSE_FILES="-f ${RELEASE_PATH}/docker-compose.yml -f ${RELEASE_PATH}/docker-compose.override.yml"
COMMAND_ENV_VARS="RAILS_MASTER_KEY=${MASTER_KEY} ${POSTGRES_USER} ${POSTGRES_PASSWORD}"

echo "Building App Image"
DOCKER_BUILDKIT=1 docker build . -t domicile_web:prod --target production --build-arg RAILS_MASTER_KEY=$MASTER_KEY

echo "Clearing tmp, Save App Image and Compress"
rm -rf /tmp/domicile_web_prod.tar
docker save domicile_web:prod | gzip > /tmp/domicile_web_prod.tar

echo "Preparing SSH Deploy Directory"
ssh $HOST mkdir -p $RELEASE_PATH

echo "Copy App Image"
scp /tmp/domicile_web_prod.tar $HOST:$RELEASE_PATH

echo "Copy Docker-Compose Files"
scp ./docker-compose.yml $HOST:$RELEASE_PATH
scp ./docker-compose.production.yml $HOST:${RELEASE_PATH}/docker-compose.override.yml

echo "Copy Manual Restart file"
scp ./manual-restart.sh $HOST:$RELEASE_PATH

echo "Clearing Old Stack"
ssh $HOST "docker stop domicile_delayed_job_1" || true
ssh $HOST "docker stop domicile_cron_job_1" || true
ssh $HOST "docker stop domicile_web_1" || true
ssh $HOST "docker stop domicile_postgres_1" || true
ssh $HOST "docker rm domicile_delayed_job_1" || true
ssh $HOST "docker rm domicile_cron_job_1" || true
ssh $HOST "docker rm domicile_web_1" || true
ssh $HOST "docker rm domicile_postgres_1" || true

echo "Clearing Docker System"
ssh $HOST "docker system prune --all -f"

echo "Load Docker Image"
ssh $HOST "docker image load -q -i ${RELEASE_PATH}/domicile_web_prod.tar"

echo "Starting Docker"
ssh $HOST "${COMMAND_ENV_VARS} docker-compose ${COMPOSE_FILES} -p domicile up -d -V"
