#!/bin/bash

WDIR=$(pwd)

OUTPUT=$WDIR/output.txt

if [ -f "$OUTPUT" ]; then
	echo "$OUTPUT exists do you want to overwrite the file? [y,n]"
	read DECISION
	if [ $DECISION == "y" ] || [ $DECISION == "Y" ]; then
		ls > output.txt
	elif [ $DECISION == "n" ] || [ $DECISION == "N" ]; then
		echo "output.txt wasn't deleted"
	else
		echo "wrong input no changes were made"
	fi	
else
	ls > output.txt
fi

ARR=( $(ls) )

for str in ${ARR[@]}; do
	echo $str
done
