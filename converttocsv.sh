#!/bin/bash
set -e
SRC=${1}
DEST=${2}
mkdir -p ${DEST}
FILES="${SRC}/*.log"
for f in $FILES
do
  echo "Processing $f file..."
  filename="${f##*/}"
  java -jar ./gcviewer-1.35-SNAPSHOT.jar $f ${DEST}/processed_$filename.csv -t CSV_TS
done
