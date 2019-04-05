#!/bin/bash
function divide () {

    awk -v n1="$1" -v n2="$2" 'BEGIN { printf "%.3f", (n1 / n2) }'

}
function full_y ()
{
    if [ "$1" == "full" ] ; then
        echo $height
    else 
        echo $1        
    fi
}
function full_x ()
{
    if [ "$1" == "full" ] ; then
        echo $width
    else 
        echo $1        
    fi
}

function mult () {

    awk -v n1="$1" -v n2="$2" 'BEGIN { printf "%.3f", (n1 * n2) }'

}
function round () {

    awk -v n1="$1" 'BEGIN { printf "%.0f", (n1 * 1) }'

}

function add () {

    awk -v n1="$1" -v n2="$2" -v n3="$3" 'BEGIN { printf "%.3f", (n1 + n2 + n3) }'

}
function sub () {

    awk -v n1="$1" -v n2="$2" -v n3="$3" 'BEGIN { printf "%.3f", (n1 - n2 -n3) }'

}

function param_exists () {
    param=$1
    value=$2
    file=$3
    
    grep $1 $3 > /dev/null 
    if [ $? == 1 ]; then
        echo "$1 = $2" >> $3
        #echo "write $1 $2 $3"

    fi

    
}

function clean_values() {

    snap_x1=$(round $snap_x1)
    snap_x2=$(round $snap_x2)
    snap_y1=$(round $snap_y1)
    snap_y2=$(round $snap_y2)
    title_x1=$(round $title_x1)
    title_x2=$(round $title_x2)
    title_y1=$(round $title_y1)
    title_y2=$(round $title_y2)
    list_x1=$(round $list_x1)
    list_x2=$(round $list_x2)
    list_y1=$(round $list_y1)
    list_y2=$(round $list_y2)
    video_x1=$(round $video_x1)
    video_x2=$(round $video_x2)
    video_y1=$(round $video_y1)
    video_y2=$(round $video_y2)
    title_font=$(round $title_font)
    list_font=$(round $list_font )
    spacing_scaled=$(round $spacing_scaled)
}
ll_path="/root/.lemonlauncher"
ll_conf="/root/.lemonlauncher/lemonlauncher.conf"
theme=$1

res_x=$(tvservice -s | cut -d"," -f2 |sed "s/ //g"| cut -d"@" -f1 |cut -d"x" -f1)
res_y=$(tvservice -s | cut -d"," -f2 |sed "s/ //g"| cut -d"@" -f1 |cut -d"x" -f2)

#Ãlow
#res_x=$(tvservice -s | cut -d" " -f4 | cut -d"x" -f1)
#res_y=$(tvservice -s | cut -d" " -f4 | cut -d"x" -f2)

#high
#res_x=$(tvservice -s | cut -d" " -f9 | cut -d"x" -f1)
#res_y=$(tvservice -s | cut -d" " -f9 | cut -d"x" -f2)
#echo $theme
#echo "$res_x x $res_y"
#exit 0
#fetching the snapshot position and dimension from theme.conf
sed -n "/^font/,/^background/p" $theme/theme.conf > /tmp/tmp_head
sed -n "/title/,/^}/p" $theme/theme.conf  > /tmp/tmp_title
sed -n "/list/,/^}/p" $theme/theme.conf  > /tmp/tmp_list
sed -n "/snapshot/,/^}/p" $theme/theme.conf > /tmp/tmp_snapshot

width=$(grep "^width" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
height=$(grep "^height" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
rotate=$(grep "^rotate" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)

snap_x1=$(full_x $(grep position /tmp/tmp_snapshot | cut -d"{" -f2| cut -d"," -f1 | xargs))
snap_y1=$(full_y $(grep position /tmp/tmp_snapshot | cut -d"{" -f2| cut -d" " -f3 | xargs))
snap_x2=$(full_x $(grep dimensions /tmp/tmp_snapshot | cut -d"{" -f2| cut -d"," -f1 | xargs))
snap_y2=$(full_y $(grep dimensions /tmp/tmp_snapshot | cut -d"{" -f2| cut -d" " -f3 | xargs))

title_x1=$(full_x $(grep position /tmp/tmp_title | cut -d"{" -f2| cut -d"," -f1 | xargs))
title_y1=$(full_y $(grep position /tmp/tmp_title | cut -d"{" -f2| cut -d" " -f3 | xargs))
title_x2=$(full_x $(grep dimensions /tmp/tmp_title | cut -d"{" -f2| cut -d"," -f1 | xargs))
title_y2=$(full_y $(grep dimensions /tmp/tmp_title | cut -d"{" -f2| cut -d" " -f3 | xargs))
title_font=$(grep font_height /tmp/tmp_title | sed "s/ //g" | cut -d"=" -f2)

list_x1=$(full_x $(grep position /tmp/tmp_list | cut -d"{" -f2| cut -d"," -f1 | xargs))
list_y1=$(full_y $(grep position /tmp/tmp_list | cut -d"{" -f2| cut -d" " -f3 | xargs))
list_x2=$(full_x $(grep dimensions /tmp/tmp_list | cut -d"{" -f2| cut -d"," -f1 | xargs))
list_y2=$(full_x $(grep dimensions /tmp/tmp_list | cut -d"{" -f2| cut -d" " -f3 | xargs))
list_font=$(grep font_height /tmp/tmp_list | sed "s/ //g" | cut -d"=" -f2)
list_spacing=$(grep spacing /tmp/tmp_list | sed "s/ //g" | cut -d"=" -f2)

# gucken welche Aufloesung hat background.png
# default ist background.png
video_x1=$(grep "^video_x1" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
video_x2=$(grep "^video_x2" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
video_y1=$(grep "^video_y1" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
video_y2=$(grep "^video_y2" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)
video_volume=$(grep "^video_volume" $theme/lemonlauncher.conf| sed "s/ //g" | cut -d"=" -f2)

param_exists "video_orientation" "0" "$theme/lemonlauncher.conf" 

# Skalierungsfaktor rausfinden
# Annahme default ist kleinster Wert
scale_x=$(divide $res_x $width)
scale_y=$(divide $res_y $height)
ratio=$(divide $width $height)

echo "scale factors $scale_x und $scale_y"
echo "lemonlauncher resolution $width x $height"

rm -r /tmp/theme_scaled
mkdir /tmp/theme_scaled
cp $theme/* /tmp/theme_scaled
# ok, we have all values



sed -i "s/^width.*/width = $res_x/" /tmp/theme_scaled/lemonlauncher.conf
sed -i "s/^height.*/height = $res_y/" /tmp/theme_scaled/lemonlauncher.conf

if [ "$rotate" == "\"right\"" ] ; then
    scale_img $theme/background.png $res_y $res_x 0 /tmp/theme_scaled/background.png > /dev/null

    dim_x=$(mult $snap_y2 $scale_y)
    dim_y=$(mult $snap_x2 $scale_x)

    video_x1=$(mult $snap_y1 $scale_y) 
    # check !!!
    video_y1=$( sub $res_y $(mult $snap_x1 $scale_x) $dim_y)

    video_x2=$( add $video_x1 $dim_x )

    video_y2=$( add $video_y1 $dim_y )
    video_y2=$( add $video_y2 2 )

    sed -i "s/^video_orientation.*/video_orientation = 270/" /tmp/theme_scaled/lemonlauncher.conf
    
elif [ "$rotate" == "\"left\"" ] ; then
    scale_img $theme/background.png $res_y $res_x 0 /tmp/theme_scaled/background.png > /dev/null
    dim_x=$(mult $snap_y2 $scale_y)
    dim_y=$(mult $snap_x2 $scale_x)

    video_x1=$(sub $res_x $(mult $snap_y1 $scale_y) $dim_x)
    video_y1=$(mult $snap_x1 $scale_x)

    video_x2=$(add $video_x1 $dim_x ) 
    video_y2=$(add $video_y1 $dim_y )
    video_y2=$( add $video_y2 2 )

    sed -i "s/^video_orientation.*/video_orientation = 90/" /tmp/theme_scaled/lemonlauncher.conf

elif [ "$rotate" == "\"flip\"" ] ; then

    scale_img $theme/background.png $res_x $res_y 0 /tmp/theme_scaled/background.png > /dev/null
#    video_x1=$(mult $snap_x1 $scale_x)
    dim_x=$(mult $snap_x2 $scale_x)

    video_x1=$(sub $res_x $(mult $snap_x1 $scale_x) $dim_x)
    
    dim_x=$(mult $snap_x2 $scale_x)
    video_x2=$(add $video_x1 $dim_x )

    dim_y=$(mult $snap_y2 $scale_y)
    video_y2=$(sub $res_y $(mult $snap_y1 $scale_y))

    video_y1=$(sub $video_y2 $dim_y )

    sed -i "s/^video_orientation.*/video_orientation = 180/" /tmp/theme_scaled/lemonlauncher.conf

else 
    scale_img $theme/background.png $res_x $res_y 0 /tmp/theme_scaled/background.png > /dev/null
    video_x1=$(mult $snap_x1 $scale_x)
    video_y1=$(mult $snap_y1 $scale_y)
    
    dim_x=$(mult $snap_x2 $scale_x)
    video_x2=$(add $video_x1 $dim_x ) 
    dim_y=$(mult $snap_y2 $scale_y)
    video_y2=$(add $video_y1 $dim_y )

    sed -i "s/^video_orientation.*/video_orientation = 0/" /tmp/theme_scaled/lemonlauncher.conf

fi

snap_x1=$(mult $snap_x1 $scale_x)
snap_y1=$(mult $snap_y1 $scale_y)

title_x1=$(mult $title_x1 $scale_x)
title_y1=$(mult $title_y1 $scale_y)

title_font=$(mult $title_font $scale_y)
#title_font=$(mult $title_font $ratio)

list_x1=$(mult $list_x1 $scale_x)
list_y1=$(mult $list_y1 $scale_y)

snap_x2=$(mult $snap_x2 $scale_x)
snap_y2=$(mult $snap_y2 $scale_y)

title_x2=$(mult $title_x2 $scale_x)
title_y2=$(mult $title_y2 $scale_y)

list_x2=$(mult $list_x2 $scale_x)
list_y2=$(mult $list_y2 $scale_y)

list_font=$(mult $list_font $scale_y)
#list_font=$(mult $list_font $ratio)
spacing_scaled=$(mult $list_spacing $scale_y)
#spacing_scaled=$(mult $list_spacing $ratio)

clean_values

sed -i "s/^video_x1.*/video_x1 = $video_x1/" /tmp/theme_scaled/lemonlauncher.conf
sed -i "s/^video_y1.*/video_y1 = $video_y1/" /tmp/theme_scaled/lemonlauncher.conf
sed -i "s/^video_x2.*/video_x2 = $video_x2/" /tmp/theme_scaled/lemonlauncher.conf
sed -i "s/^video_y2.*/video_y2 = $video_y2/" /tmp/theme_scaled/lemonlauncher.conf

#building new theme.conf
sed -i "s/position.*/position = { $snap_x1 , $snap_y1 }/" /tmp/tmp_snapshot
sed -i "s/position.*/position = { $title_x1 , $title_y1 }/" /tmp/tmp_title
sed -i "s/font_height.*/font_height = $title_font/" /tmp/tmp_title
sed -i "s/position.*/position = { $list_x1 , $list_y1 }/" /tmp/tmp_list
sed -i "s/dimensions.*/dimensions = { $snap_x2 , $snap_y2 }/" /tmp/tmp_snapshot
sed -i "s/dimensions.*/dimensions = { $title_x2 , $title_y2 }/" /tmp/tmp_title
sed -i "s/dimensions.*/dimensions = { $list_x2 , $list_y2 }/" /tmp/tmp_list
sed -i "s/font_height.*/font_height = $list_font/" /tmp/tmp_list
sed -i "s/spacing.*/spacing = $spacing_scaled/" /tmp/tmp_list


#more /tmp/theme_scaled/lemonlauncher.conf

cat /tmp/tmp_head /tmp/tmp_title /tmp/tmp_list /tmp/tmp_snapshot > /tmp/theme_scaled/theme.conf

#more /tmp/theme_scaled/theme.conf
 
#convert -rotate "270" background_480x640.png background_480x640_270.png

cp /tmp/theme_scaled/* $ll_path
