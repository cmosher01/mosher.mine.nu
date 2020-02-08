#!/bin/bash

srcdir="$(readlink -f "$1")"

cd gedcom-master-skel

gedcom-uid <$srcdir/root.ged >root.ged
gedcom-cull root.ged
gedcom-attach master.ged root.ged.cull

for ged in mosher lovejoy colvin spohner harrison taylorson mclaughlin disosway justice flandreau pettit lopez romero ; do
    gedcom-uid <$srcdir/$ged.ged >$ged.ged
    gedcom-cull $ged.ged
    gedcom-attach master.ged master.ged $ged.ged.cull
done

cd -
