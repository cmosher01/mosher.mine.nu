#!/bin/bash

if [ $# != 1 ] ; then
    echo "usage: $0 PUBDIR"
    echo '    Reads *.ged from PUBDIR, redacts, and writes to PUBDIR-private directory'
    exit 1
fi

pubdir="$1"

if [ -d "$pubdir" ] && [ -w "$pubdir" ] ; then
    :
else
    echo "$0: cannot write to directory: $pubdir" >&2
    exit 1
fi

prvdir="$pubdir-private"

if [ -d "$prvdir" ] && [ -r "$prvdir" ] ; then
    :
else
    echo "$0: cannot read from directory: $prvdir" >&2
    exit 1
fi

for ged in "$prvdir"/*.ged ; do
    prvged="$(readlink -f "$ged")"
    f="$(basename "$prvged")"
    pubged="$(readlink -f "$pubdir/$f")"

    echo "Redacting:  $prvged  -->  $pubged  ..."
    gedcom-redact <"$prvged" >"$pubged"
done
