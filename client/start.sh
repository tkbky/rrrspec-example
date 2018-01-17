#!/bin/bash

set -ex

cd example

bundle install

TASK_KEY=$(bundle exec rrrspec-client start --rsync-name example --key-only)
bundle exec rrrspec-client waitfor $TASK_KEY --config client_config.rb --pollsec=10
exec bundle exec rrrspec-client show $TASK_KEY --config client_config.rb --verbose --failure-exit-code=0
