#!/bin/bash

#test that there is only 1 argument.
if test "$#" -ne 1;
then
   echo -n "Error: Usage: ./repunctuate.sh [directory for hashlookup]"
   exit 2
fi

#get stin and save in a variable.
input=`cat`

#save stdin in a temporary file
echo "$input" > tempfile


#reversing the depunctuation steps. saving each iteration in the output variable
output=""
while IFS="" read -r p || [ -n "$p" ] #reading tempfile line by line
do
   if test -f "$1/$p"; #test if the line is a also a file. this will only be true for a hash.
   then
      output="$output$(cat $1/$p)\n" #if the line is a hash, only add its content. and newline
   else
      output="$output$p\n" # if the line is not a file, add a newline.
   fi
done < "tempfile" 

#removing the newlines and adding the original newlines.
echo -e "$output" | tr -d '\n' | tr '|' '\n' | cat
rm tempfile
