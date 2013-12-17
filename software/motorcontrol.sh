#!/bin/bash -x
#controls PWM by recieving values and then forwarding them to /dev/pi-blaster
#for more info on the project go to:  http://robogoby.blogspot.com
#Limbeck Engineering
#10.20

echo $1
echo "5=$1" > /dev/servoblaster


