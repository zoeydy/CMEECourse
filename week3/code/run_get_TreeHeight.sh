#!/bin/bash

#Author: Jane i.kotari20@imperial.ac.uk
#Script: run_get_TreeHeight.sh
#Desc: Runs the get_TreeHeights.R  and the get_TreeHeight.py scripts with the file trees.csv from the Data directory as arguement
#Date: Jan 2021

Rscript get_TreeHeight.R ../Data/trees.csv 
python3 get_TreeHeight.py ../Data/trees.csv

#exit