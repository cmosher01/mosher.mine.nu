#!/bin/sh -ex

me="$(readlink -f "$0")"
here="$(dirname "$me")"
cd "$here"





# nginx doesn't like when upstream servers go down
docker-compose stop nginx
sleep 2

# stop tei container and remove its data:
docker-compose stop tei
docker-compose stop tei2
sleep 5

docker-compose rm -f tei
docker-compose rm -f fetch-tei
docker-compose rm -f tei2
docker-compose rm -f archive
docker-compose rm -f war
sleep 2

docker volume rm -f mosherminenu_tei
docker volume rm -f mosherminenu_archive
docker volume rm -f mosherminenu_war
docker volume rm -f mosherminenu_tomcat_logs
docker volume rm -f mosherminenu_tomcat_work
docker volume rm -f mosherminenu_tomcat_temp




# pull/build latest versions
docker-compose pull
docker-compose build





# create volumes, network, and containers (but don't start)
docker-compose up --no-start

docker-compose start fetch-tei war archive ftm-web-view iip uniwebfonts unicode

sleep 9
docker-compose start tei tei2

sleep 9
docker-compose start nginx
