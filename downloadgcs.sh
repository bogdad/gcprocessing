#!/bin/bash
set -e
TO=${1}
mkdir -p ${TO}
while read p; do
    echo "${p}"
    F="${TO}/gc_$p.log"
    [ -f "$F" ] || scp ${p}:/var/log/cassandra/gc.log $F
done
