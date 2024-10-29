#!/bin/bash
sleep 1
rake db:seed

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid
exec bundle exec rails server -b 0.0.0.0
