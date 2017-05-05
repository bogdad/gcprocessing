#!/bin/bash
set -e
SRC=${1}
mkdir -p ${2}
FILES="${SRC}/*.log"
for f in $FILES
do
  echo "Processing $f file..."
  filename="${f##*/}"
  java -jar ./gcviewer-1.35-SNAPSHOT.jar $f ${2}/processed_$filename.csv -t CSV
done
