# headlesspi

Not in working order!

The headlesspi project is an attempt to ease management of a headless raspberry pi.
Basic idea is to use udev rules to copy files to and from usb stick on insertion.

For example: 
- copy basic system information (load, disk+mem usage, uptime etc.) to text file on usb stick.
- copy current ip address to text file on usb stick, so know where to ssh to.
- copy wifi settings from usb stick to raspberry pi to get access to network.

Future ideas
- Web server for management 
- automated logging from serial port on insertion of usb to serial adapter.
- bridge mode for tcpdump sniffing on insertion of wired lan adapter.
- ?

## Installation:
 
### Raspbian packages:
```
sudo apt install mc sl wiringpi git wavemon python-flask python-requests python-serial
```

### Crontab:
```
# m h  dom mon dow   command
@reboot /home/scotte/scottepi/rebootman.sh >> /home/scotte/rebootlog.txt 2>&1

```
## Notes:
USB serial converter pinout
```
Black wire GND
White wire RXD
Green wire TXD
```
