#!/bin/bash

rm -f /app/tmp/pids/server.pid

bundle exec rails db:migrate
bundle exec rails assets:precompile
bundle exec rails server -b 0.0.0.0
