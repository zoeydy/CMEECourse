#!/bin/bash

path="${1%/*}/"
echo "$path"
if [[ -z $1 || ! -e $1 ]]
then 
    echo "Please enter a image."
else
for f in $path*.tif;
	do
		echo "Converting $f";
		convert "$f" "$path$(basename "$f" .tif).png";
		# convert "$f" "${f%tif}png"
	done
fi