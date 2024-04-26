#!/bin/bash 


i=1
var=00$i

ls ./temp-sites/$var*.conf 2>&1 > /dev/null

status=$?

while [ $status -eq 0 ];
do
echo $status
i=$(( i + 1 ))
var=00$i
ls ./temp-sites/$var*.conf 2>&1 > /dev/null
status=$?
echo $status
done
echo "$var-default.conf"