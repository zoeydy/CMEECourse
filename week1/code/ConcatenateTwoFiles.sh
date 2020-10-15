#!/bin/bash
# Author: Zongyi Hu zh2720@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: concatenate two files

# Saves the output into a .txt file
# Arguments: 1 -> the first file needs to be contatenated
# Arguments: 2 -> the second file needs to be contatenated
# Arguments: 3 -> the output file

# Data: Oct 2020

if [[ -z $1 || ! -e $1 ]]
then 
    echo "Please enter a file."
elif [[ -z $2 || ! -e $2 ]]
then
    echo "Please enter a second file."
else
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is"
    cat $3
fi


