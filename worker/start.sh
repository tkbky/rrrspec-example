#!/bin/bash
set -ex

# NOTE: Must use bundle exec otherwise would get `execute_with_logs': uninitialized constant RRRSpec::Server::WorkerRunner::Bundler (NameError)
bundle exec rrrspec-server worker --config worker_config.rb --no-daemonize
