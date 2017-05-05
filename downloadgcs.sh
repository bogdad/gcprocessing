#!/bin/bash
set -e
TO=${1}
mkdirs -p TO
while read p; do
    echo "${p}"
    scp ${p}:/var/log/cassandra/gc.log ${TO}/gc_$p.log
done
