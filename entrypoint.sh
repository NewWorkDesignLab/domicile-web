#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /domicile/tmp/pids/server.pid

echo "Preparing Tables ..."
rake db:create &> /dev/null
rake db:migrate &> /dev/null

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"