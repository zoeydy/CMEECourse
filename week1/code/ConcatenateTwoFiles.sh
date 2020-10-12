#!/bin/bash

cat $1 > transformed.txt
cat $2 >> transformed.txt
echo "Merged File is"
cat transformed.txt
