#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Wait until the database is ready
echo "Waiting for the database to be ready..."
until pg_isready -h postgres -p 5432 -U postgres; do
  sleep 1
done

# Prepare the database (migrate and seed if needed)
echo "Preparing the database..."
bin/rails db:prepare

# Execute the container's main process (what's passed as CMD)
exec "$@"
