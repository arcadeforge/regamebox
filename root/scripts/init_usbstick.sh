#!/bin/bash

rm_xist()
{
    if [ -e $1 ]; then
        rm $1
    fi

}

mkdir_xist()
{
    if ! [ -d $1 ]; then
        mkdir $1
    fi

}

path="/mnt/sda"
cd $path
base=$1
if ! [ -d "$base" ]; then
    text="Valid empty USB Stick found."
    text="$text\nUSB Stick will be initialized" 
    text="$text with the folder structure."
    text="$text\nPlease wait!"

    text="$text\n\ngenerate $base folder in $path"
    whiptail --infobox "$text" 25 40
    sleep 1

    mkdir_xist $path/$base

    text="$text\ncopy regamebox folders"
    whiptail --infobox "$text" 25 40
    sleep 1

    mkdir_xist $path/$base/roms
    mkdir_xist $path/$base/snaps
    mkdir_xist $path/$base/menu-audio
    mkdir_xist $path/$base/roms_advmame
    mkdir_xist $path/$base/roms_advmame/snaps
    

    text="$text\ncopy /boot/regamebox.conf"
    whiptail --infobox "$text" 25 40
    sleep 1


    cp /boot/regamebox.conf $path/$base
    
    text="$text\ncopy retroarch files"
    whiptail --infobox "$text" 25 40
    sleep 1

    cp /boot/retroarch* $path/$base
    cp /root/templates/*.conf $path/$base

    text="$text\nclean regamebox folders"
    whiptail --infobox "$text" 25 40
    sleep 1
    
    rm_xist $path/$base/*_done
    rm_xist $path/$base/log.txt

    text="$text\ngenerating rom folders"
    whiptail --infobox "$text" 25 40
    sleep 1

    mkdir_xist $path/$base/roms/mame2003
    mkdir_xist $path/$base/roms/mame2003plus
    mkdir_xist $path/$base/roms/mame2000
    mkdir_xist $path/$base/roms/mame2010
    mkdir_xist $path/$base/roms/genesis
    mkdir_xist $path/$base/roms/pce
    #mkdir_xist $path/$base/roms/advmame
    mkdir_xist $path/$base/roms/lr-fbalpha
    mkdir_xist $path/$base/roms/snes
    mkdir_xist $path/$base/roms/gamegear
    mkdir_xist $path/$base/roms/mastersystem
    mkdir_xist $path/$base/roms/atari2600
    mkdir_xist $path/$base/roms/nes
    mkdir_xist $path/$base/roms/c64
    mkdir_xist $path/$base/roms/c64dtv
    text="$text\nFinish"
    whiptail --infobox "$text" 25 40
    sleep 3


else
    whiptail --infobox "Ups, folder $base exists on USB stick. Please delete ;)" 20 40
    sleep 5
fi
