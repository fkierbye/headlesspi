#!/bin/bash

DATE=$(date +'%Y-%m-%dT%H-%M-%S')

gpio write 29 1
echo ${DATE}: serial $1 >> /home/pi/serialmount.log 2>&1
sleep 0.5
gpio write 29 0
