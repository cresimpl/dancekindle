#!/bin/bash

help="

Generator bazy adresów url z twarzami ludzi.

Examples:
$0
"
echo $* | grep -q -s -e '--help' -e '-h ' -e '-h$'
if [ $? -eq 0 ]; then echo "$help"; exit 1; fi

### parametry
#for arg in "$@"
#do
#	case ${arg} in
#	  "-gen") par=$(echo ${arg}|sed 's/-//');;
#	  "-age") par=$(echo ${arg}|sed 's/-//');;
#	  "-q") par=$(echo ${arg}|sed 's/-//');;
#	  *) eval "${par}=\"${arg}\""
#	esac
#done

### get img url

### echo img urls
for gen in woman man
do
	for age in 20 30 40 50 60 70
	do
		if [ -e ${gen}_${age}.db ]; then rm -f ${gen}_${age}.db; echo del ${gen}_${age}.db; fi

		img_url=($(wget -e robots=off --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:31.0) Gecko/20100101 Firefox/31.0" -qO - "www.google.pl/search?q=${gen} age ${age}&tbs=itp:face&tbm=isch" | grep -oP "(?<=imgurl=)[^\;]+(.jpg)"))

		for img in ${img_url[@]}
		do
			echo $img >> ${gen}_${age}.db
		done

		echo "
		#img=${#img_url[@]}

		query:
		"
		echo "www.google.pl/search?q=${gen} age ${age}&tbs=itp:face&tbm=isch"
	done
done

