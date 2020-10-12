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


echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
#exit
