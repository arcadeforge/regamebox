#!/bin/bash

echo "# added video config by script" >> $1/lemonlauncher.conf


sed -n "/snapshot/,/alpha/p" $1/theme.conf > tmp
video_x1=$(grep position tmp | cut -d"{" -f2| cut -d"," -f1 | xargs)
video_y1=$(grep position tmp | cut -d"{" -f2| cut -d" " -f3 | xargs)
x2=$(grep dimension tmp | cut -d"{" -f2| cut -d"," -f1 | xargs)
y2=$(grep dimension tmp | cut -d"{" -f2| cut -d" " -f3 | xargs)

grep rotate $1/lemonlauncher.conf | cut -d"\"" -f2 > tmp_rotate
rotate=$(cat tmp_rotate)
rm tmp_rotate

video_x2=$(( $video_x1 + $x2))
video_y2=$(( $video_y1 + $y2))


sed -i "/video_*/d" $1/lemonlauncher.conf


echo "video_x1 = $video_x1" >> $1/lemonlauncher.conf
echo "video_y1 = $video_y1" >> $1/lemonlauncher.conf
echo "video_x2 = $video_x2" >> $1/lemonlauncher.conf
echo "video_y2 = $video_y2" >> $1/lemonlauncher.conf

if [ "$rotate" == "right" ] ; then
    echo "video_orientation = 270" >> $1/lemonlauncher.conf
fi

tail -n 10 $1/lemonlauncher.conf
rm tmp

sed -i "/video = */d" $1/lemonlauncher.conf

echo "video = \"/mnt/sda/rpi2jamma/videos/%r.mp4\"" >> $1/lemonlauncher.conf

