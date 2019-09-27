#!/bin/bash -x

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

prvnam=$1
pubnam=${prvgit%-private}

if [ $pubnam = $prvnam ] ; then
    echo "Private repo name must end with '-private'" >&2
    exit 1
fi

prvgit=$2
pubgit=${prvgit/%-private.git/.git}

if [ ! -d $pubnam ] ; then
    git clone $pubgit
fi

if [ ! -d $prvnam ] ; then
    git clone $prvgit
fi

gedcom-redact $prvnam

cd $pubnam
git status
