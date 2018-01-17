#!/bin/bash
set -ex

function at_exit() {
  service ssh stop
}

service ssh start
trap "at_exit" EXIT

until MYSQL_PWD="$RRRSPEC_DATABASE_PASSWORD" mysqladmin ping -h "$RRRSPEC_DATABASE_HOST"
do
  sleep 3
done

bundle exec rake rrrspec:server:db:create rrrspec:server:db:migrate
foreman start -f Procfile
