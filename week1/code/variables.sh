#!bin/bash

#Shows the use of variables
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new stirng'
read MyVar
echo 'the current value of the variable is' $MyVar

##Reading multiple values
echo 'Enter two numbers separated by space(s)'
read a b 
mysum=`expr $a + $b`
echo 'you entered' $a 'and' $b '. Their sum is :'
echo $mysum
