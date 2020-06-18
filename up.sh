#!/bin/sh -ex



me="$(readlink -f "$0")"
here="$(dirname "$me")"
cd "$here"

# nginx doesn't like when upstream servers go down
docker-compose stop nginx
sleep 1





# stop gedcom and tei containers and remove their data:
docker-compose stop gedcom-web-view
docker-compose stop tei
sleep 5

docker-compose rm -f gedcom-web-view
docker-compose rm -f fetch-gedcom
docker-compose rm -f tei
docker-compose rm -f fetch-tei
sleep 2

docker volume rm -f docker_gedcom
docker volume rm -f docker_tei





# pull/build latest versions
docker-compose pull
docker-compose build





# create volumes, network, and containers (but don't start)
docker-compose up --no-start



docker-compose start fetch-tei fetch-gedcom

docker-compose start iip uniwebfonts unicode webhook

sleep 5
docker-compose start tei gedcom-web-view

sleep 9
docker-compose start nginx
