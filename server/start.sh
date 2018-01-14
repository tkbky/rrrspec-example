#!/bin/bash
set -ex

function at_exit() {
  service ssh stop
}

service ssh start
trap "at_exit" EXIT

until MYSQL_PWD="$DB_PASSWORD" mysqladmin ping -h "$DB_HOST"
do
  sleep 3
done

rake -f /usr/local/bundle/gems/rrrspec-server-0.4.4/tasks/db.rake rrrspec:server:db:create rrrspec:server:db:migrate RRRSPEC_CONFIG_FILES=server_config.rb

rrrspec-server server --config=server_config.rb --no-daemonize
