#!/bin/bash

DATE=$(date +'%Y-%m-%dT%H-%M-%S')

gpio write 29 1
echo ${DATE}: removed $1 >> /home/pi/mediamount.log 2>&1
sleep 0.2
gpio write 29 0
