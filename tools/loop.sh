#!/bin/sh

FILE_LIST=list.txt
URL="http://api.map.baidu.com/geocoder?address=ADDR&output=json&key=37492c0ee6f924cb5e934fa08c6b1676&city=%E4%B8%8A%E6%B5%B7"
TMP=address
mkdir ${TMP} 

while read line
do
    echo Get detail for ${line}
    road=`echo ${line}|cut -d "|" -f2`
    district=`echo ${line}|cut -d "|" -f2`
    #echo ${road}
    get_url=`echo ${URL}|sed "s/ADDR/${road}/g"`
    filename=`echo ${road}|md5sum|cut -d " " -f1`
    wget  ${get_url} -O ${TMP}/${district}_${road}_${filename}.json
done<${FILE_LIST}
