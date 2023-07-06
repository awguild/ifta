#!/bin/sh

set -e

cd /app
bundle install
bundle exec rails s -b 0.0.0.0