#!/usr/bin/env bash

set -e

docker-compose up --remove-orphans --build -d

docker-compose exec --user root php rm -rf /var/www/html/var/cache/dev /var/www/html/var/cache/test
docker-compose exec --user www-data php chmod -R 777 /var/www/html/var

docker-compose exec --user www-data php bin/console doctrine:database:drop -n --force
docker-compose exec --user www-data php bin/console doctrine:database:create -n
docker-compose exec --user www-data php bin/console doctrine:migrations:migrate -n -q
docker-compose exec --user www-data php bin/console doctrine:schema:update --dump-sql