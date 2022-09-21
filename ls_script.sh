#!/bin/bash

WDIR=$(pwd)

OUTPUT=$WDIR/old_names.txt

if [ -f "$OUTPUT" ]; then
	echo "$OUTPUT exists do you want to overwrite the file? [y,n]"
	read DECISION
	if [ $DECISION == "y" ] || [ $DECISION == "Y" ]; then
		ls > $OUTPUT
	elif [ $DECISION == "n" ] || [ $DECISION == "N" ]; then
		echo "old_names.txt wasn't deleted"
	else
		echo "wrong input no changes were made"
	fi	
else
	ls > $OUTPUT
fi
