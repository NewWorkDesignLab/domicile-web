#!/usr/bin/env sh
set -e


# ONLY USE ON DEPLOAYED SERVER TO RESTART CONTAINER MANUALLY
# use to e.g. rollback to specific version

echo "Clearing Old Stack"
docker stop domicile_delayed_job_1 || true
docker stop domicile_cron_job_1 || true
docker stop domicile_web_1 || true
docker stop domicile_postgres_1 || true
docker rm domicile_delayed_job_1 || true
docker rm domicile_cron_job_1 || true
docker rm domicile_web_1 || true
docker rm domicile_postgres_1 || true

echo "Clearing Docker System"
docker system prune --all -f

echo "Load Docker Image"
docker image load -q -i domicile_web_prod.tar

echo "Starting Docker"
RAILS_MASTER_KEY=${1} POSTGRES_USER=${2} POSTGRES_PASSWORD=${3} docker-compose -p domicile up -d -V
