#!/bin/bash

if [ ${#?[*]} -eq 0 ]; then echo -e "Skrypt sprawdzający ilość tancerzy na danym obszarze geograficznym.\n\n UWAGA! Brak parametrow, przyklad: \n x1.xxx x2.xxx y1.yyy y2.yyy \n\n Gdansk: \n 54.29 54.43 18.43 18.74"; exit 1; fi

x1=$1
x2=$2
y1=$3
y2=$4

i=0
for c in $(cat coordinates.db) ; do

a=$(echo $c|cut -d, -f1)
b=$(echo $c|cut -d, -f2)

if [ $(echo "$a >= $x1"|bc) -eq 1 ] && [ $(echo "$a <= $x2"|bc) -eq 1 ] &&  [ $(echo "$b >= $y1"|bc) -eq 1 ] && [ $(echo "$b <= $y2"|bc) -eq 1 ]; then ((i++)); fi
done
echo trafien $i
