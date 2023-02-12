#!/bin/bash


WDIR=$(pwd)

OUTPUT=$WDIR/old_names.txt

ARRAY=($(ls))


NEW_ARRAY=()
TO_DEL=()

for i in ${!ARRAY[@]}; do
	ELEMENT=${ARRAY[$i]}
	CONTINUE=0
	for (( y=0; y<${#ELEMENT}; y++ )); do
		CHAR="${ELEMENT:y:1}"
		ASCII_CODE=$(printf "%d\n" "'$CHAR")
		if [ $ASCII_CODE -gt 40 ] && [ $ASCII_CODE -lt 91 ]; then
			CONTINUE=1
			break
		elif [ $ASCII_CODE -gt 47 ] && [ $ASCII_CODE -lt 58 ]; then
			CONTINUE=1
			break
		elif [ $ASCII_CODE -gt 96 ] && [ $ASCII_CODE -lt 123 ]; then
			CONTINUE=1
			break
		fi
	done

	if [ $CONTINUE -eq 1 ]; then
		continue
	else
		TO_DEL+=($i)
	fi
done

for i in ${!TO_DEL[@]}; do
	unset 'ARRAY[$i]'
done

ARRAY=( "${ARRAY[@]}" )

for i in ${!ARRAY[@]}; do
	ELEMENT=${ARRAY[$i]}
	NAME=""
	OLD_STATE=0;
	for (( y=0; y<${#ELEMENT}; y++ )); do
		CHAR="${ELEMENT:y:1}"
		ASCII_CODE=$(printf "%d\n" "'$CHAR")

		if [ $ASCII_CODE -eq 95 ]; then
			# if equals to '-'
			NAME+='_'
		elif [ $ASCII_CODE -eq 46 ]; then
			# if equals to '.'
			NAME+="${ELEMENT:y:$((${#ELEMENT} - y + 1))}"
			break
		elif [ $ASCII_CODE -gt 64 ] && [ $ASCII_CODE -lt 91 ]; then
			# if is upper
			CURRENT_STATE=1;
			if ! [ $(($OLD_STATE-$CURRENT_STATE)) -eq 0 ]; then
				NAME+="_";
			fi
			NAME+=$(printf "\x$(printf %x $(($ASCII_CODE+32)))")
		elif [ $ASCII_CODE -gt 47 ] && [ $ASCII_CODE -lt 58 ]; then
			# if is number
			CURRENT_STATE=2;
			if ! [ $(($OLD_STATE-$CURRENT_STATE)) -eq 0 ]; then
				NAME+="_";
			fi
			NAME+=$CHAR
		elif [ $ASCII_CODE -gt 96 ] && [ $ASCII_CODE -lt 123 ]; then
			# if is lower
			CURRENT_STATE=3;
			if ! [ $(($OLD_STATE-$CURRENT_STATE)) -eq 0 ]; then
				NAME+="_";
			fi
			NAME+=$CHAR
		else
			# if is forbiden
			echo "FORBIDEN"
		fi

		OLD_STATE=$CURRENT_STATE

	done

	NAME=${NAME#?}
	if [[ -z "$NAME" ]]; then
		unset 'ARRAY[$i]'
		ARRAY=( "${ARRAY[@]}" )
		((i--))
	else
		NEW_ARRAY+=($NAME)
	fi
done 

echo "PLEASE CHECK!!!"
for i in ${!ARRAY[@]}; do
	echo "mv ${ARRAY[$i]} ${NEW_ARRAY[$i]}"
done
echo "Type in 'yes' to confrim renames."

read INPUT
if [ $INPUT == "yes" ]; then
	for i in ${!ARRAY[@]}; do
		mv ${ARRAY[$i]} ${NEW_ARRAY[$i]}
	done
	echo "commands executed"
else
	echo "no changes were made"
fi