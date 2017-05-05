#!/bin/bash
FILES=${1}
for f in $FILES
do
  echo "Processing $f file..."
  java -jar target/gcviewer-1.35-SNAPSHOT.jar $f processed_$f.csv -t CSV
done
