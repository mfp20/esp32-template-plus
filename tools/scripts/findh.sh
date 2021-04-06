#!/bin/sh

declare -a OBJS=$(ar -t sources/ports/esp32/build/upython.a | sort)

FOUND=""
DIRS=""
NOTFOUND=""
for i in $OBJS; do
	h=$(echo $i | cut -d"." -f"1").h

	FOUND+="$(find -name $h) "

	find . -name $h | grep '.' 2&>1
	if [ $? -eq 1 ]; then
		NOTFOUND+="$h "
	fi
done

for i in $FOUND; do
	DIRS+="$(dirname "$i") "
done
DIRS=$(echo $DIRS | xargs -n1 | sort -u | xargs)
for i in $DIRS; do
	echo $i
done


#echo "FOUND: " $FOUND
#echo "DIRS: " 
#echo "NOTFOUND: " $NOTFOUND

#cp --parents `find -name ` $h prova/

