#!/bin/bash
# Author: Zongyi Hu zh2720@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute the csv inn the files with space
#
# Saves the output into a .txt file
# Arguments: 1 -> tab delimited file
# Data: Oct 2020

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

if [[ -e $1.txt ]]
then
    echo "Do you want to replace $1.txt? "yes"or"no""
    read
        if $REPLY == "yes"
        then
        cat $1 | tr -s "," " " >> $1.txt
        echo "Done!"
        elif $REPLY == "no"
        then
        echo "Would you like to quit or build a new file? "Q" or "B""
        read 
            if $REPLY == "Q"
            then
            echo "Quit!"
            elif $REPLY == "B"
            then
            cat $1 | tr -s "," " " > $1_1.txt # fix if the file is also already existed.
            echo "Done!"
        fi
        fi
else
    cat $1 | tr -s "," " " > $1.txt
    fi
exit