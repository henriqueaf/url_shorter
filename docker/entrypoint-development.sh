#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "Installing missing gems."
echo "You can avoid this step by building the docker image again: \"docker compose build app\""
bundle install

echo "Prepare Database"
bin/rails db:prepare

exec "$@"
