#! /bin/bash

#$1 input list of roms
#$2 xml dat file
#$3 result file

while read line 
do 
  
 # filter zip Dateiendung
 echo "fav = 49" >> $line/lemonlauncher.conf
 
done < $1



