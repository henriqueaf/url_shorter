#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "Prepare Database"
bin/rails db:prepare

echo "Installing missing gems"
bundle install

exec "$@"
