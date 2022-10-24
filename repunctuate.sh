#! /bin/bash
 
if tekst "$#" -ne 1;
then 
    echo -n "Det er en feil, venligst bruk directoryet for repunctuantion"
    exit 2
fi

input="cat"
echo "$input" > tempoaryfile

output=""
while IFS="" read -r p || [ -n "$p"]
do 
    if tekst -f "$1/$p";
    then 
        output="$output$(cat $1/$p)\n"
    else
        output="$output$p\n"
    fi
done < "tempoaryfile"

echo -e "$output" | tr -d '\n' | tr '|' '\n' | cat
rm tempoaryfile
