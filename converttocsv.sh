#!/bin/bash
set -e
SRC=${1}
DEST=${2}
mkdir -p ${DEST}
FILES="${SRC}/*"
for f in $FILES
do
  [[ $f =~ bz2$ ]] && continue
  echo "Processing $f file..."
  filename="${f##*/}"
  java -jar ./gcviewer-1.35-SNAPSHOT.jar $f ${DEST}/processed_$filename.csv -t CSV_TS_BOTH
done
