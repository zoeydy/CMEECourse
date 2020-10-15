#!/bin/bash
#Author: zongyi zh2720@imperial.ac.uk
#Script: tabtoscv.sh
#Description: substitute the tabs in the files with commas
#
#Saves the output into a .csv file
#Arguments: 1 -> tab delimited file
#Date: Oct 2019

if [[ -z $1 || ! -e $1 ]]
then
    echo "Please input a correct file."
exit 1
fi

if [[ -e $2 ]]
then 
    echo "Please just input one file."
exit
fi

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
#exit
