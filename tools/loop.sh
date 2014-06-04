#!/bin/sh

FILE_LIST=list.txt
FILE_LIST_PREPARED=list_prepared.txt
URL="http://api.map.baidu.com/geocoder?address=ADDR&output=json&key=37492c0ee6f924cb5e934fa08c6b1676&city=%E4%B8%8A%E6%B5%B7"
TMP=address
mkdir ${TMP} 
rm ${FILE_LIST_PREPARED} 

while read line
do
    echo Get detail for ${line}
    road=`echo ${line}|cut -d "|" -f2`
    district=`echo ${line}|cut -d "|" -f1`
    #echo ${road}
    get_url=`echo ${URL}|sed "s/ADDR/${road}/g"`
    filename=`echo ${line}|md5sum|cut -d " " -f1`
    echo "${filename}|${line}" >>${FILE_LIST_PREPARED}
    wget  ${get_url} -O ${TMP}/${filename}
done<${FILE_LIST}
