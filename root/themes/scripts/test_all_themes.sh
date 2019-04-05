#! /bin/bash

#$1 input list of roms
#$2 xml dat file
#$3 result file

while read line 
do 
 
 # filter zip Dateiendung
 rom=$(echo $line)
 ./prepare_theme.sh /root/themes/themes/$rom
 lemonlauncher
  
done < $1



