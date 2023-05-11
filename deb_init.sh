#!/bin/bash

docker-compose up -d;

chmod -R 777 pgadmin_data;
echo 'chmod pgadmin_data success';

function check_postgres_is_ready() {
  if docker-compose logs postgres | grep 'database system is ready to accept connections'; then
    echo "postgres is ready";
    return "1";
  else
    echo "postgres is not ready yet";
    return "0";
  fi
}

while check_postgres_is_ready
do
  docker-compose logs postgres | grep 'database system is ready to accept connections';
  echo 'wait';
  sleep 1;
done

chmod -R 777 pgdata;
echo 'chmod pgdata success'

docker-compose logs -f;