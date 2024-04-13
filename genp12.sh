#!/bin/sh

cd $(mktemp -d)
dir=$(pwd)

cert=$(ls -t /etc/letsencrypt/archive/mosher.mine.nu/fullchain* | head -n 1)
priv=$(ls -t /etc/letsencrypt/archive/mosher.mine.nu/privkey* | head -n 1)

ls -l $cert $priv

openssl pkcs12 -inkey $priv -in $cert -export -passout pass: -out mosher.mine.nu.p12

openssl pkcs12 -nokeys -info -in mosher.mine.nu.p12 -passin pass:

echo $dir
ls -lt

echo "ls $dir/mosher.mine.nu.p12"
