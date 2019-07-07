#!/bin/sh -ex



# REFERENCED DIRECTORIES/FILES
# ./mosher.mine.nu (contains main web site)
# ./images (contains ptif images)
# ~/.ssh/id_rsa (private key to access github repositories)
# /etc/letsencrypt (TLS certificates)
#
# MANUAL SETUP:
# start WinGeneal VM (must be set up with ftm share)
#   run as root: copy_ftm_media_from_running_vm.sh
#   to copy media to ./mosher.mine.nu/ftm



# stop gedcom and tei containers and remove their data:
docker-compose stop gedcom-web-view
docker-compose rm gedcom-web-view
docker-compose rm fetch-gedcom
docker volume rm -f docker_gedcom

docker-compose stop tei
docker-compose rm tei
docker-compose rm fetch-tei
docker volume rm -f docker_tei

# pull latest versions
docker-compose pull

# create volumes, network, and containers (but don't start)
docker-compose up --no-start




docker-compose start fetch-tei fetch-gedcom



docker-compose start iip unicode


sleep 10
docker-compose start tei gedcom-web-view

sleep 4
docker-compose start nginx
