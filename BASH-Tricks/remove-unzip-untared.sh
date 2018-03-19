#!/bin/bash

# This script helps in searching and removing accidentally unzipped or untared files in a directory.
# Please do not use this incase unzipped or untared directory has overwritten existing files.
# Those ovewritten files won't come back with this script

COUNT=0
PURGE=CLEAR
FORMAT=$1
FILE=$2

if [ "${FORMAT}" == "tar" ]
then
	PURGE=(`tar tfz ${FILE} | xargs echo`)
elif [ "${FORMAT}" == "zip" ]
then
	PURGE=(`unzip -t ${FILE} | awk '{print $2}' |  xargs echo`)
fi

COUNT=${#PURGE[@]}
echo "total items "$COUNT
echo -e "item at 0 is ${PURGE[0]}"

# Kill them all
while [ "$COUNT" -gt 0 ]
do
	echo -e "deleting ${PURGE[${COUNT}]}"
	rm -r "${PURGE[${COUNT}]}"
	COUNT=$[ $COUNT - 1 ]
done
exit 0

# Incase you are a boring person then just use line 14 or 17 to directly delete the files, by replacing "echo" with "rm -rf"
