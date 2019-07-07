#!/bin/bash
set -e
set -o xtrace



if ! [ $(id -u) = 0 ] ; then
    echo "ERROR: Must be run a root."
    exit 1
fi



# mount media from running FTM VM (which must have appropriate sharing alerady set up)
cd /media
if [ -d ftm ] ; then
    rmdir ftm
fi
mkdir ftm
mount -v -t cifs -o credentials=/root/ftm.cifs -o vers=1.0 //$(nmblookup WIN-2483CVUPCDI|head -n1|awk 'END{print $1}')/ftm ftm
cd ftm



# remove old destination media and create new empty directory
dest=/home/user/docker/mosher.mine.nu/ftm
if [ ! "$dest" ] ; then
    exit 1
fi
if [ -f "$dest" ] ; then
    echo "ERROR: $dest is a file."
    exit 1
fi
if [ -d "$dest" ] ; then
    rm -R "$dest"/*
    rmdir "$dest"
fi
mkdir $dest



# copy media from relevant FTM trees to destination directory
for t in \
    'Colvin' \
    'cranson' \
    'Disosway' \
    'Flandreau' \
    'Harrison' \
    'Justice' \
    'Lopez' \
    'Lovejoy' \
    'Mosher' \
    'Pettit' \
    'Romero' \
    'Roth' \
    'Spohner' \
    'Taylorson' \
    'Taylerson_Taylorson(1)'
do
    echo "======================================================================="
    ls -ld "$t Media"
    mkdir "$dest/$t Media"
    cp -v "$t Media"/* "$dest/$t Media"
done


cd ..
umount /media/ftm
rmdir ftm
