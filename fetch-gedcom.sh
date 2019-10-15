#!/bin/sh

apk update
apk add git
apk add openssh
apk add tree

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

cd
mkdir src
cd src
for r in "$@" ; do
    git clone "$r"
done

# copy top-level .ged files only
# (files in subdirectories will not be served)
cd
cp -v ./src/*/*.ged ./gedcom/
rm -Rf src
tree

cp /root/authorized.emails ./gedcom/SERVE_PUBLIC_GED_FILES
