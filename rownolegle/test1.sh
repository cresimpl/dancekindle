#!/bin/bash

### help ###

help="
----------
   HELP
----------
Polecenie:
$0 <il_gen_usr> <il_zad> <il_cpu_max> <nazwa_db>

Przykład:
$0 1000 10 4 testbaza

"

echo $* | grep -q -s -e '--help' -e '-h ' -e '-h$' &&  echo "$help" && exit 1

### parametry ###
il_gen_usr="$1"
il_zad="$2"
il_cpu_max="$3"
n_db="$4"

### testy ###
if [ $# -lt 4 ]; then echo -e "\nUWAGA! - Brak parametrow!\n\nWywołaj: $0 --help\n"; exit 1; fi

### tablice ###
## tablica imiona_m
	echo '-> Wczytywanie bazy imiona_m...'
	start=$(date +%s)
	t_imiona_m=()

	k=0; for i in $(cat imiona_m.txt)
	do
		t_imiona_m[k]=$i
		k=$((k+1))
	done

	il_imiona_m=${#t_imiona_m[*]}
	echo "OK - Wczytano ${il_imiona_m} nazwisk do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica imiona_k
	echo '-> Wczytywanie bazy imiona_k...'
	start=$(date +%s)
	t_imiona_k=()

	k=0; for i in $(cat imiona_k.txt)
	do
		t_imiona_k[k]=$i
		k=$((k+1))
	done

	il_imiona_k=${#t_imiona_k[*]}
	echo "OK - Wczytano ${il_imiona_k} nazwisk do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica nazwisk
	echo '-> Wczytywanie bazy nazwisk...'
	start=$(date +%s)
	t_nazwiska=()

	k=0; for i in $(cat nazwiska.txt|cut -d" " -f 2)
	do
		t_nazwiska[k]=$i
		k=$((k+1))
	done

	il_nazwiska=${#t_nazwiska[*]}
	echo "OK - Wczytano ${il_nazwiska} nazwisk do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_20_k
	echo '-> Wczytywanie bazy photo_20_k...'
	start=$(date +%s)
	t_photo_20_k=()

	k=0; for i in $(cat photo_20_k.txt)
	do
		t_photo_20_k[k]=$i
		k=$((k+1))
	done

	il_photo_20_k=${#t_photo_20_k[*]}
	echo "OK - Wczytano ${il_photo_20_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_30_k
	echo '-> Wczytywanie bazy photo_30_k...'
	start=$(date +%s)
	t_photo_30_k=()

	k=0; for i in $(cat photo_30_k.txt)
	do
		t_photo_30_k[k]=$i
		k=$((k+1))
	done

	il_photo_30_k=${#t_photo_30_k[*]}
	echo "OK - Wczytano ${il_photo_30_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_40_k
	echo '-> Wczytywanie bazy photo_40_k...'
	start=$(date +%s)
	t_photo_40_k=()

	k=0; for i in $(cat photo_40_k.txt)
	do
		t_photo_40_k[k]=$i
		k=$((k+1))
	done

	il_photo_40_k=${#t_photo_40_k[*]}
	echo "OK - Wczytano ${il_photo_40_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_50_k
	echo '-> Wczytywanie bazy photo_50_k...'
	start=$(date +%s)
	t_photo_50_k=()

	k=0; for i in $(cat photo_50_k.txt)
	do
		t_photo_50_k[k]=$i
		k=$((k+1))
	done

	il_photo_50_k=${#t_photo_50_k[*]}
	echo "OK - Wczytano ${il_photo_50_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"


## tablica photo_60_k
	echo '-> Wczytywanie bazy photo_60_k...'
	start=$(date +%s)
	t_photo_60_k=()

	k=0; for i in $(cat photo_60_k.txt)
	do
		t_photo_60_k[k]=$i
		k=$((k+1))
	done

	il_photo_60_k=${#t_photo_60_k[*]}
	echo "OK - Wczytano ${il_photo_60_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_70_k
	echo '-> Wczytywanie bazy photo_70_k...'
	start=$(date +%s)
	t_photo_70_k=()

	k=0; for i in $(cat photo_70_k.txt)
	do
		t_photo_70_k[k]=$i
		k=$((k+1))
	done

	il_photo_70_k=${#t_photo_70_k[*]}
	echo "OK - Wczytano ${il_photo_70_k} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_20_m
	echo '-> Wczytywanie bazy photo_20_m...'
	start=$(date +%s)
	t_photo_20_m=()

	k=0; for i in $(cat photo_20_m.txt)
	do
		t_photo_20_m[k]=$i
		k=$((k+1))
	done

	il_photo_20_m=${#t_photo_20_m[*]}
	echo "OK - Wczytano ${il_photo_20_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_30_m
	echo '-> Wczytywanie bazy photo_30_m...'
	start=$(date +%s)
	t_photo_30_m=()

	k=0; for i in $(cat photo_30_m.txt)
	do
		t_photo_30_m[k]=$i
		k=$((k+1))
	done

	il_photo_30_m=${#t_photo_30_m[*]}
	echo "OK - Wczytano ${il_photo_30_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_40_m
	echo '-> Wczytywanie bazy photo_40_m...'
	start=$(date +%s)
	t_photo_40_m=()

	k=0; for i in $(cat photo_40_m.txt)
	do
		t_photo_40_m[k]=$i
		k=$((k+1))
	done

	il_photo_40_m=${#t_photo_40_m[*]}
	echo "OK - Wczytano ${il_photo_40_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_50_m
	echo '-> Wczytywanie bazy photo_50_m...'
	start=$(date +%s)
	t_photo_50_m=()

	k=0; for i in $(cat photo_50_m.txt)
	do
		t_photo_50_m[k]=$i
		k=$((k+1))
	done

	il_photo_50_m=${#t_photo_50_m[*]}
	echo "OK - Wczytano ${il_photo_50_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_60_m
	echo '-> Wczytywanie bazy photo_60_m...'
	start=$(date +%s)
	t_photo_60_m=()

	k=0; for i in $(cat photo_60_m.txt)
	do
		t_photo_60_m[k]=$i
		k=$((k+1))
	done

	il_photo_60_m=${#t_photo_60_m[*]}
	echo "OK - Wczytano ${il_photo_60_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

## tablica photo_70_m
	echo '-> Wczytywanie bazy photo_70_m...'
	start=$(date +%s)
	t_photo_70_m=()

	k=0; for i in $(cat photo_70_m.txt)
	do
		t_photo_70_m[k]=$i
		k=$((k+1))
	done

	il_photo_70_m=${#t_photo_70_m[*]}
	echo "OK - Wczytano ${il_photo_70_m} indeksow do bazy - czas $(( $(date +%s) - $start )) sekund"

### zmienne ###

## gps - y0 y1 x0 x1
pl=(49.22 54.84 14.14 23.92)
pl_gd=()

gps=(${pl[@]})

### funkcje ###
function rand1 {
	max=$1
	echo $(($RANDOM % ${max}))
}

function rand2 {
	min=$1
	max=$2
	shuf -i ${min}-${max} -n 1
}

function generator {
il_gen_usr="$1"

for ((i=1; $i<=${il_gen_usr}; i++))
do
	gender="$(rand1 2)"; if [ ${gender} -eq 0 ]; then g=k; else g=m; fi
	age="$(rand2 20 79)"
	if [ $age -lt 30 ]; then age2=20; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
	if [ $age -ge 30 ] && [ $age -lt 40 ]; then age2=30; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
	if [ $age -ge 40 ] && [ $age -lt 50 ]; then age2=40; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
	if [ $age -ge 50 ] && [ $age -lt 60 ]; then age2=50; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
	if [ $age -ge 60 ] && [ $age -lt 70 ]; then age2=60; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
	if [ $age -ge 70 ] && [ $age -lt 80 ]; then age2=70; eval $(echo pic_max_${g}=\${il_photo_${age2}_${g}[@]}); fi
# echo pic_max $pic_max_k $pic_max_m
	if [ $gender -eq 1 ]
	then
		m=$(rand1 ${il_imiona_m})
		first_name="${t_imiona_m[$m]}"
		p=$(rand1 ${pic_max_m});# echo ppppp $p
		picture_url="$(eval echo $(echo \${t_photo_${age2}_m[p]}))"
	else
		k=$(rand1 ${il_imiona_k})
		first_name="${t_imiona_k[$k]}"
		p=$(rand1 ${pic_max_k});# echo ppppp $p
		picture_url="$(eval echo $(echo \${t_photo_${age2}_k[p]}))"
	fi

	n=$(rand2 0 ${il_nazwiska})

	last_name="${t_nazwiska[n]}"
	d="$(rand1 60)"
	dances="$d"
	description="Hey, this is my awesome description"
	email="${first_name}_${last_name}@dancekindle.com"
	facebook_id="10153571901369408"
	height="$(rand2 135 189)"
	map_y="$(rand2 ${gps[0]} ${gps[1]})"
	map_x="$(rand2 ${gps[2]} ${gps[3]})"
	registered="data"

	echo "${zad} - ${gender} ${first_name} ${last_name} age ${age} da ${dances} de ${description} em ${email} fb ${facebook_id} he ${height} y ${map_y} x ${map_x} p ${picture_url} reg ${registered}" >> ${zad}.db
done
}

function process {
zad="$1"
il_gen_usr=$2

	echo "${zad} start"
	generator ${il_gen_usr}
	echo "${zad} done"
}

function job_wait {
	local limit=${1:-2}
 
	while [ $(jobs | wc -l) -ge $limit ] ; do
		sleep 0.1;
		jobs &> /dev/null
	done
}

### MAIN ###
############

for ((i=1; $i<=${il_zad}; i++)) ; do 
	process zad${i} ${il_gen_usr} & 
	job_wait ${il_cpu_max} 
done 

wait
