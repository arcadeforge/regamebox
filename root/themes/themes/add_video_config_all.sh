#! /bin/bash

#$1 input list of roms
#$2 xml dat file
#$3 result file

while read line 
do 
 
 # filter zip Dateiendung
 rom=$(echo $line)
 ./add_video_config.sh $rom
 
done < $1



