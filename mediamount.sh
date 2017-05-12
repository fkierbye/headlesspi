#!/bin/bash

#udev rules from
#https://www.axllent.org/docs/view/auto-mounting-usb-storage/
#plus extra rules to run this scipt

#get date
#no colon as time seperator because it is used for filename on FAT
DATE=$(date +'%Y-%m-%dT%H-%M-%S')

/home/pi/fastblink.sh &

echo ${DATE}: mounted $1 >> /home/pi/mediamount.log 2>&1

if [ -f /home/pi/Logger/systemdata.json ]; then
	cp -v /home/pi/Logger/systemdata.json ${1}/RaspberryPiLogger_systemdata_${DATE} >> /home/pi/mediamount.log 2>&1
else
	#create empty file just to get timestamp
	touch ${1}/RaspberryPiLogger_systemdata_${DATE} >> /home/pi/mediamount.log 2>&1
fi

WIFI=${1}/wifi.conf
if [ -f ${WIFI}  ]; then
	echo found vaild wifi config ${WIFI1} >> /home/pi/mediamount.log 2>&1
	if [ "$(head -n1 ${WIFI})" == "network={" -a "$(tail -n1 ${WIFI})" == "}" ]; then
	    echo ${WIFI} file found and valid, adding to /etc/wpa_supplicant/wpa_supplicant.conf >> /home/pi/mediamount.log 2>&1
	    cat ${WIFI} >> /etc/wpa_supplicant/wpa_supplicant.conf
	    echo "" >> /etc/wpa_supplicant/wpa_supplicant.conf
	    mv -v ${WIFI} ${WIFI}.added
	else
	    echo ${WIFI} file found, but not valid >> /home/pi/mediamount.log 2>&1
	    echo head $(head -n1 ${WIFI}) >>  /home/pi/mediamount.log 2>&1
	    echo tail $(tail -n1 ${WIFI}) >> /home/pi/mediamount.log 2>&1
	fi
else
	echo ${WIFI} file not found, or not valid >> /home/pi/mediamount.log 2>&1
fi

shopt -s nullglob
for f in `ls /home/pi/*.txt`
do
    echo rsync $f
    echo rsync $f $1/ >> /home/pi/mediamount.log 2>&1
    rsync $f $1/ >> /home/pi/mediamount.log 2>&1
done

sync

sleep 3

killall fastblink.sh
gpio write 29 0
