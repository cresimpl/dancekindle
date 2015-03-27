#!/bin/bash

help="

Info help

Parameters:
 -url \"http://...\"
 -gen \"f/m\"
 -age \"20\"

Examples:
$0 -gen f -age 20 -url 'https://www.google.pl/search?hl=pl&site=imghp&tbm=isch&source=hp&biw=1280&bih=909&q=woman+age+20&oq=woman+age+20&gs_l=img.3...3554.7554.0.10098.12.12.0.0.0.0.100.759.11j1.12.0.msedr...0...1ac.1.64.img..1.11.657._bLSuWJsw9M#q=women+age+20&hl=pl&tbs=itp:face,isz:m&tbm=isch'
"
echo $* | grep -q -s -e '--help' -e '-h ' -e '-h$'
if [ $? -eq 0 ]; then echo "$help"; exit 1; fi

### parametry
for arg in $@; do case ${arg} in "-url") par=$(echo ${arg}|sed 's/-//');; "-gen") par=$(echo ${arg}|sed 's/-//');; "-age") par=$(echo ${arg}|sed 's/-//');; *) eval "${par}=\"${arg}\"";  esac; done

if [ ! $gen = f ] && [ ! $gen = m ]; then echo "zly paramert -gen $gen"; exit 1; fi
if [ $gen = m ]; then gen=1; fi
if [ $gen = f ]; then gen=2; fi

### get img url
page=$(wget --user-agent 'Mozilla/5.0' -qO - "$url")
echo "$page" > page.html
img_url=($(echo "$page"|sed 's/</\n</g'|grep '<img'| sed 's/.*src="\([^"]*\)".*/\1/'))

### download img
mkdir img
cd img

for img in ${img_url[@]}
do
wget $img
done

i=${gen}${age}0000
for img in $(ls images*); do mv $img ${i}.jpg; ((i++)); done

cd ..
