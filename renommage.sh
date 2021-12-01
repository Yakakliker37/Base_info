#!/bin/sh

## Les variables
: ${VAR01=whiptail}
: ${VAR02=/etc/sysconfig}
: ${VAR03=`date +%d%m%y`} 
: ${VAR04=/root/Documents}


: ${FILE=dshield.rsc}
#$ FILE=${FILE%.*}_`date +%d%b%y`.${FILE#*.}

cp dshield.rsc dshield.rsc.$VAR03