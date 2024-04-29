#!/bin/sh -ex

me="$(readlink -f "$0")"
here="$(dirname "$me")"
cd "$here"



docker compose stop nginx
sleep 2

docker compose stop tei
sleep 4

docker compose rm -f tei
docker compose rm -f archive
sleep 2

docker volume rm -f mosherminenu_archive



docker compose pull



docker compose up --no-start

docker compose start archive ftm-web-view iip uniwebfonts unicode arkn2t

sleep 8
docker compose start tei

sleep 8
docker compose start nginx
