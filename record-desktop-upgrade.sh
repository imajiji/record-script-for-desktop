#!/bin/bash

if [ $# -eq 1 ]; then
  urllist=$1
else
  echo "Not enough args."
  exit 1
fi

cat $urllist | while read url; do
  echo $url
done
