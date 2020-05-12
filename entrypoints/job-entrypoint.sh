#!/bin/bash
set -e

echo "[JOB] Waiting for db ..."
declare retry=0
while !(pg_isready -U postgres -h 127.0.0.1) && $retry < 5; do sleep 1; $retry ++; done;

# echo "[WEB] Waiting for Tables ..."
# # depends on custom db:exists Task to check if database exists (lib/tasks/db_exists.rake)
# # Source: https://stackoverflow.com/a/35732641
# while $retry < 10; do rake db:exists && break || echo "."; $retry ++; sleep 2; done;

echo "[JOB] Executing start command ..."
bundle exec rails jobs:work
