#!/bin/bash
set -e
TO=${1}
TMP=./tmp
mkdir -p ${TO}
while read p; do
    echo "${p}"
    mkdir -p ${TMP}
    F="${TO}/gc_$p.log"
    [ -f "$F" ] || scp -C "${p}:/var/log/cassandra/gc.log*" $TMP
    for file in ./tmp/*; do
        filename="${file##*/}"
        mv "$file" "${TO}/${p}_${filename}"; 
    done
    rm -rf ./tmp
done
