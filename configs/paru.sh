#!/usr/bin/env sh

FILENAME="./aur.txt"

while read -r LINE
do
    paru -Qs "$LINE" > /dev/null || paru -S "$LINE" 
done < $FILENAME
