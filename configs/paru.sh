#!/bin/env sh

FILENAME="./aur.txt"

for LINE in $(cat $HOME/aur.txt)
do
    paru -Qs "$LINE" > /dev/null || paru -S "$LINE" 
done
