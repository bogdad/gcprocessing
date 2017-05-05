#!/bin/bash
while read p; do
    echo "${p}"
    scp ${p}:/var/log/cassandra/gc.log $1/gc_$p.log
done
