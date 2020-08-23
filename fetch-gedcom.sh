#!/bin/sh

apk update
apk add git
apk add openssh
apk add tree

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

ls -al ~/.ssh

echo "clone all github repos, each into their own subdirectory under src directory..."
cd
mkdir src
cd src
for r in "$@" ; do
    git clone "$r"
done

for d in * ; do
    cd $d
    ls -l *.ged
    git log -n 5
    git diff --stat HEAD^
    cd ..
done

echo "copy top-level (only) *.ged files from all repos into staging directory..."
# (files in subdirectories will not be served)
cd
mkdir -p ./shared/staging/
cp -v ./src/*/*.ged ./shared/staging/
rm -Rfv src
tree

cp -v /root/authorized.emails ./shared/staging/SERVE_PUBLIC_GED_FILES
cp -v /root/REGEX_PATH_TO_URL ./shared/staging/REGEX_PATH_TO_URL

echo "rename staging to gedcom (an atomic operation)..."
# so Gedcom-Web-View will start reading *.ged files from it
cd shared
rm -Rfv gedcom
mv -nv staging gedcom
