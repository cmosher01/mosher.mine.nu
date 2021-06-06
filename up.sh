#!/bin/sh -ex

me="$(readlink -f "$0")"
here="$(dirname "$me")"
cd "$here"





# nginx doesn't like when upstream servers go down
docker-compose stop nginx
sleep 2

# stop tei container and remove its data:
docker-compose stop tei
sleep 5

docker-compose rm -f tei
docker-compose rm -f fetch-tei
sleep 2

docker volume rm -f mosherminenu_tei





# pull/build latest versions
docker-compose pull
docker-compose build





# create volumes, network, and containers (but don't start)
docker-compose up --no-start

docker-compose start fetch-tei ftm-web-view iip uniwebfonts unicode

sleep 9
docker-compose start tei

sleep 9
docker-compose start nginx
