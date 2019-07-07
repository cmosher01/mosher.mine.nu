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

cd
cp -v ./src/*/.SERVE_PUBLIC.globs ./tei/
cp -r ./src/*/* ./tei/
rm -Rf src
ls -la tei
tree -d
