path="/root/themes/themes"
path_higres="/root/themes/themes_highres"

ls $path > /root/databases/themes.list
ls $path_highres > /root/databases/themes_highres.list

if [ -e /mnt/sda/rpi2jamma ]; then
    work_dir=/mnt/sda/rpi2jamma/snaps
else
    work_dir=/home/x/rpi2jamma/snaps
fi

while read theme 
do 

    if [ -f $path/$theme/background.png ]; then
        cp $path/$theme/background.png $work_dir/$theme.png
        #echo "cp $theme" 
    fi
done < /root/databases/themes.list

while read theme 
do 

    if [ -f $path_highres/$theme/background.png ]; then
        cp $path_highres/$theme/background.png $work_dir/$theme.png
        echo "cp $theme" 
    fi
done < /root/databases/themes_highres.list

