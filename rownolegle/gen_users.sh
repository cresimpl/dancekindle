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
if [ -d ${n_db} ]; then rm -r ${n_db}; fi; mkdir -p ${n_db}


### zmienne ###
wczytaj=(imiona_m imiona_k nazwiska $(echo photo_{20,30,40,50,60,70}_{m,k}))
### tablice ###
## Wczytywanie tablic
for dane in ${wczytaj[@]} 
do
	eval "$(echo "
	echo \"-> Wczytywanie bazy ${dane}...\"
	start=\$(date +%s)
	t_${dane}=()

	k=0; for i in \$(cat ${dane}.txt)
	do
		t_${dane}[k]=\$i
		k=\$((k+1))
	done

	il_${dane}=\${#t_${dane}[*]}
	echo \"   OK - Wczytano \${il_${dane}} indeksów do bazy - czas \$(( \$(date +%s) - \$start )) sekund\"")"
done

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

function addusr2db {

dance_id="${dances}"

echo -n "$(if [ $i -eq 1 ] && [ $z -eq 1 ]; then echo -n "["; else echo -n ","; fi )
                    {
                        \"age\" : ${age},
                        \"dances\" : [
                                {
                                        \"dance_id\" : ${dance_id},
                                        \"learn_time\" : ${learn_time},
                                        \"like\" : ${like}
                                }
                        ],
                        \"description\" : \"Hey, this is my awesome description\",
                        \"email\" : \"${first_name}_${last_name}@dancekindle.com\",
                        \"facebook\" : {
                                \"id\" : \"20153571901369408\"
                        },
                        \"first_name\" : \"${first_name}\",
                        \"gender\" : \"${gender1}\",
                        \"height\" : ${height},
                        \"last_name\" : \"${last_name}\",
                        \"location\" : {
                                \"type\" : \"Point\",
                                \"coordinates\" : [
                                        ${map_x}.${map_x1},
                                        ${map_y}.${map_y1}
                                ]
                        },
                        \"picture\" : \"${picture_url}\",
                        \"registered\" : \"2015-03-24T20:37:50.711Z\"
                    }" >> ${n_db}/${zad}.db
                    if [ ${z} -eq ${il_zad} ] && [ ${il_gen_usr} -eq $i ]; then echo -e "\n]" >> ${n_db}/${zad}.db; fi
			
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
	if [ $gender -eq 1 ]
	then
		m=$(rand1 ${il_imiona_m})
		first_name="${t_imiona_m[$m]}"
		p=$(rand1 ${pic_max_m})
		picture_url="$(eval echo $(echo \${t_photo_${age2}_m[p]}))"
		gender1="male"
	else
		k=$(rand1 ${il_imiona_k})
		first_name="${t_imiona_k[$k]}"
		p=$(rand1 ${pic_max_k})
		picture_url="$(eval echo $(echo \${t_photo_${age2}_k[p]}))"
		gender1="female"
	fi

	n=$(rand2 0 ${il_nazwiska})
	last_name="${t_nazwiska[$n]}"
	d="$(rand1 60)"
	dances="$d"
	description="Hey, this is my awesome description"
	email="${first_name}_${last_name}@dancekindle.com"
	facebook_id="10153571901369408"
	height="$(rand2 135 189)"
	map_y="$(rand2 ${gps[0]} ${gps[1]})"
	map_x="$(rand2 ${gps[2]} ${gps[3]})"
	map_y1="$(rand1 9999)"
	map_x1="$(rand1 9999)"

	registered="data"
	learn_time="$(rand1 5)"
	like="$(rand1 5)"
	

 	addusr2db
done
}

function process {
zad="$1"
il_gen_usr=$2

	echo "${zad} start"
	start=$(( $(date +%s) ))
	generator "${il_gen_usr}"
	echo Proces wykonal sie w $(( $(date +%s) - $start )) sek
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

startall=$(( $(date +%s) ))

for ((z=1; $z<=${il_zad}; z++)) ; do 
	process zad${z} ${il_gen_usr} & 
	job_wait ${il_cpu_max} 
done 

wait

la=$(( $(date +%s) - $startall ))

echo "$(date) - Zadanie \"$0 $*\" wykonalo sie w $la sek" | tee >> stats.log
