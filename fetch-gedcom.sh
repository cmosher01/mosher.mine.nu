#!/bin/sh

apk update
apk add git
apk add openssh
apk add tree

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# clone all github repos, each into their own subdirectory under src directory
cd
mkdir src
cd src
for r in "$@" ; do
    git clone "$r"
done

# copy top-level (only) *.ged files from all repos into staging directory
# (files in subdirectories will not be served)
cd
mkdir -p ./shared/staging/
cp -v ./src/*/*.ged ./shared/staging/
rm -Rf src
tree

cp /root/authorized.emails ./shared/staging/SERVE_PUBLIC_GED_FILES

# rename staging to gedcom (an atomic operation)
# so Gedcom-Web-View will start reading *.ged files from it
mv ./shared/staging ./shared/gedcom
