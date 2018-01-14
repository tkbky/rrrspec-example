#!/bin/bash

TASK_KEY=$(bundle exec bin/rrrspec-client start --config client_config.rb --rsync-name client --key-only)
bundle exec bin/rrrspec-client waitfor $TASK_KEY --config client_config.rb --pollsec=10
exec bundle exec bin/rrrspec-client show $TASK_KEY --config client_config.rb --verbose --failure-exit-code=0
