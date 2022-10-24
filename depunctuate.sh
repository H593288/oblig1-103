#!/bin/bash
folder=$1

#Lager en tekst fil som den senere sletter
#Legge inn beskjed til bruker

#Legger tekst inn i fil og starter å dele opp teksten
tekst=$(cat)
tekst=$(echo "$tekst" | sed -z 's/\n/|/g')
tekst=$(echo "$tekst" | sed -z 's/\</\n/g')
tekst=$(echo "$tekst" | sed -z 's/\>/\n/g')
# Går gjennom linjene og når den møter på en bokstav så hopper den over 
# Men når den møter på et symbol eller mellomrom så hasher den
mkdir $1
while IFS= read -r line
do
    if [[ "$line" =~ [^[:alpha:]]*[^[:alpha:]] ]];
    then
    hash=`echo -n $line | sha256sum | awk '{print $1}'`;
    touch "$1/$hash"
    echo -n "$line" > "$1/$hash"
    printf '%s\n' "$hash"
    else
     printf '%s\n' "$line"
    fi
#printf $output
done <<< "$tekst"
