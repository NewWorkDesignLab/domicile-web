#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /domicile/tmp/pids/server.pid

echo "[WEB] Waiting for db ..."
declare retry=0
while !(pg_isready -U postgres -h 127.0.0.1) && $retry < 5; do sleep 1; $retry ++; done;

echo "[WEB] Checking yarn ..."
command -v yarn install --check-files

echo "[WEB] Preparing Tables ..."
# depends on custom db:exists Task to check if database exists (lib/tasks/db_exists.rake)
# Source: https://stackoverflow.com/a/35732641
rake db:exists && rake db:migrate || rake db:setup

echo "[WEB] Executing start command ..."
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
