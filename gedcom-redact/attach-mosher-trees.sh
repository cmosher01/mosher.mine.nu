#!/bin/bash -ex

srcdir="$(readlink -f "$1")"

echo "Will attach gedcoms in: $srcdir"
ls -lt $srcdir

cd gedcom-master-skel

rm *.cull
rm *.ged

gedcom-uid <$srcdir/root.ged >root.ged
gedcom-cull root.ged
gedcom-attach master.ged root.ged.cull

for ged in mosher lovejoy colvin spohner harrison taylorson mclaughlin disosway justice flandreau pettit lopez romero ; do
    echo "Culling: $ged"
    gedcom-uid <$srcdir/$ged.ged >$ged.ged
    gedcom-cull $ged.ged
    gedcom-attach master.ged master.ged $ged.ged.cull
done

ls -lt

cd -
