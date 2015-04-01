#!/bin/bash

echo $* | grep -q -s -e '--help' -e '-h ' -e '-h$'; echo $?

startall=$(date +%s)

echo
date
echo -----------------------------------------------------

### PARAMETRY ###
ilosc=$1


### ZMIENNE ###
t_male=(mezczyzna, kobieta)

echo '-> Wczytywanie bazy imion żeńskich...'
start=$(date +%s)

#88
t_imiona_k=(Ada Agata Agnieszka Aleksandra Alicja Amelia Andżelika Aneta Anita Anna Barbara Beata Bernadeta Blanka Bogusława Bożena Cecylia Celina Dagmara Danuta Daria Diana Dominika Dorota Edyta Eliza Elżbieta Emilia Ewa Ewelina Felicja Gabriela Grażyna Halina Hanna Helena Ilona Irena Irmina Iwona Izabela Jadwiga Joanna Jolanta Julia Justyna Kamila Karolina Katarzyna Kinga Klaudia Krystyna Laura Lena Lucyna Luiza Łucja Magdalena Maja Małgorzata Maria Mariola Marlena Marta Martyna Marzena Milena Mirosława Monika Nadia Natalia Nikola Nina Olga Oliwia Otylia Patrycja Paulina Renata Sabina Sylwia Teresa Urszula Weronika Wiktoria Zofia Zuzanna Żaneta)

echo "
OK - Wczytano ${#t_imiona_k[*]} imion do bazy - czas $(( $(date +%s) - $start )) sekund
"

echo '-> Wczytywanie bazy imion męskich...'
start=$(date +%s)

#73
t_imiona_m=(Adam Adrian Aleksander Andrzej Antoni Arkadiusz Arnold Artur Bartłomiej Bartosz Błażej Bogusław Bolesław Cezary Cyprian Czesław Damian Daniel Dariusz Dawid Dominik Emil Eryk Filip Franciszek Grzegorz Hubert Igor Ireneusz Jacek Jakub Jan Janusz Jarosław Jerzy Kacper Kamil Karol Konrad Krystian Krzysztof Leszek Łukasz Maciej Marcin Marek Mariusz Mateusz Michał Mikołaj Miłosz Mirosław Norbert Oskar Patryk Paweł Piotr Przemysław Radosław Rafał Robert Roman Sebastian Sławomir Stanisław Sylwester Szymon Tadeusz Tomasz Wiesław Włodzimierz Wojciech Zbigniew)

echo "
OK - Wczytano ${#t_imiona_m[*]} imion do bazy - czas $(( $(date +%s) - $start )) sekund
"

echo '-> Wczytywanie bazy nazwisk...'

start=$(date +%s)

t_nazwiska=()

k=0
for i in $(cat nazwiska.txt|cut -d" " -f 2)
do
t_nazwiska[k]=$i
k=$((k+1))
done

il_nazwisk=${#t_nazwiska[*]}

echo "
OK - Wczytano ${il_nazwisk} nazwisk do bazy - czas $(( $(date +%s) - $start )) sekund
"

name=""
surname=""
male=""
k=0
m=0

db="users.db"

### PORZADKI ###
if [ -e $db ]; then rm -rf $db; echo "-> plik $db usuniety !"; fi

### FUNKCJE ###
rand() {
min=$1
max=$2

r=$(shuf -i ${min}-${max} -n 1)

echo $r
}

rand_old() {
	min=$1
	max=$2

	r=$RANDOM

	if [ $r -gt $min ] && [ $r -lt $max ]; then
		echo -n $r
	   else
		while [ $r -gt $max ]; do
			r=$(( $r / 13 ))
			if [ $r -lt $min ]; then
			r=$(( ($min + $max) / 5 ))
			fi
		done
	fi

	echo $r
}

### MAIN ###
echo '
-> Generowanie uzytkownikow...
'
start=$(date +%s)
echo

for (( i=1; $i <= $ilosc ; i++ ))
do

	## ZMIENNE
	male=$(rand 0 1)

	if [ $male -eq 1 ]; then
		m=$(rand 1 73); gender=man; echo -n "m"; ((++cm))
		name=${t_imiona_m[$m]}
	  else
		k=$(rand 1 88); gender=woman; echo -n "k"; ((++ck))
		name=${t_imiona_k[$k]}
	fi	

	n=$(rand 0 ${il_nazwisk})
	surname="${t_nazwiska[$n]}"

	age="$(rand 15 69)"

	height=$(rand 110 190)

	dance_id="$(rand 1 60)"
	mark_time="$(rand 1 5)"
	mark_like="$(rand 1 5)"

	map_x_end="$(rand 1000000 9999999)"
	map_x="$(rand 14 24).${map_x_end}"
	map_y_end="$(rand 1000000 9999999)"
	map_y="$(rand 49 54).${map_y_end}"

	if [ $age -lt 30 ]; then age2=20; fi
	if [ $age -lt 40 ]; then age2=30; fi
	if [ $age -lt 50 ]; then age2=40; fi
	if [ $age -lt 60 ]; then age2=50; fi
	if [ $age -lt 70 ]; then age2=60; fi
	if [ $age -lt 80 ]; then age2=70; fi
	file="${gender}_${age2}.db"
	max_photo=$(cat $file|wc -l)
	url_photo_id=$(rand 1 $max_photo)
	url_photo=$(cat $file |head -n${url_photo_id}|tail -n1)

	## FUNCTION
	echo -n "$(if [ $i -eq 1 ]; then echo -n "["; else echo -n ","; fi ) 
	    {
		\"age\" : ${age},
		\"dances\" : [
			{
				\"dance_id\" : \"${dance_id}\",
				\"learn_time\" : \"${mark_time}\",
				\"like\" : \"${mark_like}\"
			}
		],
		\"description\" : \"Hey, this is my awesome description\",
		\"email\" : \"${name}_${surname}@dancekindle.com\",
		\"facebook\" : {
			\"id\" : \"10153571901369408\"
		},
		\"first_name\" : \"${name}\",
		\"gender\" : \"${male}\",
		\"height\" : \"${height}\",
		\"last_name\" : \"${surname}\",
		\"location\" : {
			\"type\" : \"Point\",
			\"coordinates\" : [
				${map_x},
				${map_y}
			]
		},
		\"picture\" : \"${url_photo}\",
		\"registered\" : ISODate(\"2015-03-24T20:37:50.711Z\"),
	    }" >> $db
done
echo "
]" >> $db

printf "%s %s\n" $(grep coordinates -A2 $db|sed -e '/coordinates/d' -e 's/,//' -e '/--/d'|awk {'print $1'})|awk {'print $2 "," $1'} > coordinates.db

echo
echo
echo "
Generowanie $ilosc uzytkownikow (k=$ck m=$cm) zajelo $(( $(date +%s) - $start )) sekund
wielkosc bazy: $(ls -l -h $db | cut -d" " -f5)

-----------------------------------------------------
Calkowity czas dzialania programu $(( $(date +%s) - $startall )) sekund

$(date)

"
