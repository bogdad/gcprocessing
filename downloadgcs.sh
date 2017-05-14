#!/bin/bash
set -e
TO=${1}
mkdir -p ${TO}
while read p; do
    echo "${p}"
    TMP=`mktemp -d` || exit 1
    echo $TMP
    F="${TO}/gc_$p.log"
    [ -f "$F" ] || scp -C "${p}:/var/log/cassandra/gc.log*" $TMP
    for file in ${TMP}/*; do
        filename="${file##*/}"
        mv "$file" "${TO}/${p}_${filename}"; 
    done
    rm -rf $TMP
done
