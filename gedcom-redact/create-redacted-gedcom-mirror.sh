#!/bin/bash

echo "=========================================================== $0"

export LANG=C.UTF-8

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

prvnam=$1
pubnam=${prvnam%-private}

if [ $pubnam = $prvnam ] ; then
    echo "Private repo name must end with '-private'" >&2
    exit 1
fi

prvgit=$2
pubgit=${prvgit/%-private.git/.git}

if [ -d $pubnam ] ; then
    cd $pubnam
    git fetch
    git rebase
    cd -
else
    git clone $pubgit
fi

if [ -d $prvnam ] ; then
    cd $prvnam
    git fetch
    git rebase
    cd -
else
    git clone $prvgit
fi

cd $prvnam
comit=$(git rev-parse HEAD)
cd -

echo "start redact-gedcoms-git-repos..."
redact-gedcoms-git-repos.sh $pubnam

cd $pubnam
git add .
git status
git config --global user.email "cmosher01@gmail.com"
git config --global user.name "Christopher A. Mosher"
git commit -m "Redacted mirror of $comit"
git push
cd -

echo "start attach-mosher-trees..."
attach-mosher-trees.sh $prvnam
