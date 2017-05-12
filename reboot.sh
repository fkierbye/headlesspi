#!/bin/bash

#define scotte home dir, use absolute paths when running from cronjob
project_path="/home/pi/"

# get time and date
ymdhm=`date +'%Y-%m-%d %H:%M'`
echo -en "Woke up after reboot at: "
echo "$ymdhm" 

/usr/bin/python $project_path/setuppins.py

cd $project_path/Server/
/usr/bin/python logger.py 2>&1 /dev/null &
