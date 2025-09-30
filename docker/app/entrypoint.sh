#!/bin/bash
set -e
 
echo "bundle installation"
bundle check || bundle install
 
echo "checking database..."
if ! bundle exec rails db:version > /dev/null 2>&1; then
  echo "database not found, creating..."
  bundle exec rails db:create
  bundle exec rails db:schema:load
fi
 
echo "database migration"
bundle exec rails db:migrate
 
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
 
exec "$@"