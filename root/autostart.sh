#!/bin/bash
##############



# known bugs : menu issue. Exit game jumps from gamelist in history. Fix hash in lemonlauncher
# retroarch bug : Failed saving when core is active. goto quick menu, close content, make settings again and goto configuration, save configuration
#     appears in mame2003 and mame2003plus

# regamebox - by Jochen Zurborg
### version 2.6
# 20190307
# added menu png and complere 6 button gamepad retroarch and ll configuration and lemon configuration 
# installed omxplayer and ffmpeg

# fixed lemonlauncher to handle usb gamepads with analog thumbsticks
# added hotkey, game exit, retroarch menu to joy setup wizard
# fixed chrashes on joy wizard that messes up lemonlauncher
# added support for analog thumb sticks for joy setup wizard
# fix vertical setup gets lost after reboot fix
# fixed bugs when selecting themes in vertical setup.
# added games with tag romof=neogeo to parents.  
# added new theme snap
# rework of logs and fixed some bugs for rotation.
# added parameter SHOW_ALL for showing all games in vertical setup. 
# added simple_pin, simple_pin2, simple_pin_vert, simple_pin_vert2 from
#     from pinHp Image to regamebox. thanks for this.

# todo deploy  
# todo download snap
# todo rename folder rpi2jamma/roms_advmame to rpi2jamma/snaps_advmame if exists
# todo poll usb controllers for automatic config

# regamebox - by Jochen Zurborg
### version 2.5.2

# fix in init_usb_folders.sh for generating usb stick folder structure
# added progress notification for generating usb stick folder structure
# fixed bug in grep arcade rom resolution

### version 2.5 

# change 07.02.2019
# wrote some concept in own_docs
# put suffix handling for mame2003plus
# put general arcade folder and general fba folder neogeo in emulator.cfg
# filter bin in psx

# change 05.02.2019
# generated new gamelists for advmame, mame2000, mame2003plus and put them 
#     all in the mame_list_full.csv and mame_list_parent.csv
# bugfixing init usb stick handling : extract the generate folder on usb stick
#     from the function mount_usb_stick and made a own function that comes
#     after the autoconfig of pi2scart and pi2jamma. This was needed because 
#     parameter config is needed before generating folder for user input
# checked all missing roms for mame2000, mame2003plus, advmame and lr-fbalpa
  
# change 01.02.2019
# new emu mame2003 plus, folder mame2003plus
# added mame2003plus to gamelister
# new resolution file according mame2003 plus dat
# new mame gamelist full file according mame2003 plus dat
# new mame gamelist parent file according mame2003 plus dat
# new highres def video settings in retroarch
# bugfixing handling of flip, vertical and horizontal screen
# new parameter rotation for rotation in compute_res_cmd.py
# new feature refresh gamelist in gamelist menu
# new parameter to turn automatic refresh of gamelist on and off
# now editing gamelist can take effect with no refresh
# fix fallback resolution when no res is found
# fix c64 start issue, not tested
# new hotkey start p2, joy p2 up = coin p2
# mame2003 setting no warning and no disclaimer

###version 2.4

# change 10.01.2012
# added gpio_26_on and _off for turning monitor with param auto_turn_screen
# bugfix for using vert games on hori screen. TODO Test
# made c64dtv support
# made common highscore use for advmame, lr-fbalpha, mame2000, mame2003, mame2010
# lemonlauncher resolution is now fetched from /boot/config.txt
# made the optimized shell res selectable with param opt_cmdshell_res

# change 08.01.2012
# added hat handling for joy_wizard
# bugfixing generating usb stick folders on startup

###release v2.4 18.12.2018 for tester##########

# change 18.12.2018
# added joy_wizard
# 

# change 15.12.2018
# bugfixing the center image function.
# CRT Profiles bugfixing, consumer_base_profile did overwrites 
#   the user made settings.
# corrected whiptail dialog
# bugfixing remap fba on and off 

# change 14.12.2018
# turned automatic handling of game remap off (handleUSBGamepad, buttonlayout)
# made a parameter for remap_fba and set it default to No
# set wait time for pi2jamma check to 0.5s


# change 12.12.2018
# added retroarch logging when DEBUG mode
# added xinmotek 2 Player USB PCB to retroarch autoconfig
# released patch 001

################## Release v2.3 ######################
# change 09.12.2018 
# added arcade_crt_profile
# added automatic check for pi2scart or pi2jamma detection. 
#       use option pi2scart=A

# change 04.12.2018 
# added menu for selecting crt profile consumer, sony pvm or arcade crt
# added dialog for setting new costum crt profile after calibration tool use
# added USB Gamepad dialog in configuration - options - gamepads - select usb gamepad
# added extra menu subitem for wifi, keyboard, gamecontroller and hardware
# added into menu TODO fix pi2jamma controls 

# change 02.12.2018
# added refresh gamelist to configuration - game lists - refresh game lists

# change 01.12.2018 
# made /root/.config/retroarch/system folder for highscore
# added system_dir /root/.config/retroarch/system to retroarch.cfg
# made a link from .advance/hi to /root/.config/retroarch/system/highscore - works
# made a link from fba to /root/.config/retroarch/system/highscore - works
# made a link from mame2000 to /root/.config/retroarch/system/highscore - doesnt work
# made a link from mame2003 to /root/.config/retroarch/system/highscore - doesnt work
# made a link from mame2010 to /root/.config/retroarch/system/highscore - doesnt work
# check mame20xx highscore save
# added hi2txt in scripts and work
# added keyboards de, uk, us, fr
# reworked wifi

# change 30.11.2018
# extended wifi-menu wait time to 20 seconds to get active and reboot fix wlan
# corrected show ip adress window
# put show help in autostart instead of extra script.
# cleared some whiptail messages like show modes and other

# change 27.11.2018
# bugfixing

# change 26.11.2018
# finshed python scripts compute_res_cmd.py and calibrate_screen.py
# integrated calibrate screen in regamebox
# integrated compute res in regamebox
# added compute res feature for consoles and arcade setups. 
# only vertical games on horitzontal screens has a fixed res now.
# fixed bugs in toggle screen for horizontal and vertical screens
# added 5 sec sleep for waiting on connection
# added a fallback for rom resolution that are not in arcade_res_table.txt
# added usb_gamepad parameter to show mode
# added loglevel to log_msg and all log messages
# added whiptail infobox, msgbox and yesno dialouges
# code refactoring

# change 22.11.2018
# fixes in handlingGamePad for lemonlauncher
# added handling of usb gamepads when changing themes
# added lemonlauncher template plus handling of game controllers
# read_custom_res - eliminated awk scripts to speed up
# added rom_freq in get_rom_resolution
# renamed function custom_res_set to set_custom_res
# reworked set_arcade_resolution by using new compute_res python script
# added advance comp and scan packages to /root/local/bin

# changes 03.10.2018
# - added an removed dtoverlay=sdhost,overclock_50=100 to config.txt
# - removed man db service from startup
# - installed chrony
# - added lemonlauncher for ps3, xbox one, snes usb

# changes 02.10.2018
# - impl new version of ll with parameter config for usb gamepads
# - added autoconfig for ps3, xbox one, snes usb
# - downloaded autoconfig usb dev from online updater but all defect

# change 28.09.2018
# - made a remap for nes core
# - made a remap for snes core
# - made a remap for genesis core
# - made a remap for genesis Street Fighter Game
# - made a remap for mastersystem core
# - made a remap for gamegear core
# - made a remap for pce core
# - installed git

# change 27.09.2018
# - added whiptail infoboxes for config
# - throw out buggy and unsecure wifi settings by config file
# - added import config to options - system menu
# - added disable wlan to options - system menu
# - added function set overscan for menu
# - added function generate usb stick folders to options - system
# - added function to copy rom frm usb stick to sd card in options - system
# - reworked backup script




# TODO
# - delayed start of timesyncd services

VERSION="Regamebox v2.6 work 20190221"
# T for Time measures and Y for debugging
#DEBUG="T"
DEBUG="N"
#DEBUG="Y"



if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  echo "autostart.sh script should not be run via SSH"
  # perhaps for debug reasons?
  exit;
fi


# Declaration of constants
BASE_FOLDER="rpi2jamma"
USB_PATH="/mnt/sda/$BASE_FOLDER"
SD_PATH="/home/x/$BASE_FOLDER"


N247LAUNCH=/root/scripts/n247launch
M4ALLHOME=/usr/local/share/mame4all-pi
PIFBAHOME=/usr/local/share/piFBA
ADVHOME=/root/.advance

retroarch_folder="/root/.config/retroarch"
retroarch_conf="$retroarch_folder/retroarch.cfg"
retroarch_cores="$retroarch_folder/cores"

database="/root/databases"
ctrl_path="/root/usb_controller"

ORIENTATION="H"
ORIENTATION_V="left"
ORIENTATION_H="normal"
MODE="admin"
PI2SCART="N"
CUSTOMRESMODE="N"
menu_audio="arcade.pls"
FAVOURITESMODE="N"
HISTORYMODE="N"
AUDIOMODE="N"
RESMODE="LOW"
AUTOSTART="0"
SHOW_PARENTS="Y"
SHOW_ALL="Y"
BUTTONLAYOUT="6"
USB_GAMEPAD="nousb"
SCREEN_PROFILE="custom"
USBSTICK_INIT="invalid"
REMAP_FBA="N"
INIT_REGAMEBOX="N"
auto_turn_screen="N"
opt_cmdshell_res="Y"
REFRESH_GAMELIST="Y"

# this function set a paramter in the configs file
# and adapts the games.config

#n247 central log function call

function clear_screen () {
    if [ "$DEBUG" == "N" ] ; then 
        clear
    fi
}

function log_msg()
{
    LOG_LEVEL="$2"
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
       echo `date +%T_%F` $1
    fi
    if [ "$LOG_LEVEL" == "0" ];then
        echo "`date +%T_%F` $1" >> /root/log.txt
    fi
    if [ "$LOG_LEVEL" == "1" ];then
        if [ "$DEBUG" == "Y" ] ; then 
            echo "`date +%T_%F` $1" >> /root/log.txt
        fi
    fi
}
log_msg "**************************************************" 0
log_msg "**************************************************" 0
log_msg "**************************************************" 0
log_msg "Regamebox version $VERSION started." 0

#n247 build launch cmd
function make_launch()
{

    if [ "$1" == "init" ];then
        
        rm_xist $N247LAUNCH/launch.sh
        touch $N247LAUNCH/launch.sh
        chmod +x $N247LAUNCH/launch.sh
        if [ -e "$N247LAUNCH/launch.pre" ]; then

            if [ "$RESMODE" == "LOW" ] && [ "$CUSTOMRESMODE" == "Y" ]; then
                log_msg "use no loading screen" 1
            else
                log_msg "Adding Launcher Init" 1 
                cat "$N247LAUNCH/launch.pre" >> "$N247LAUNCH/launch.sh"
            fi
        fi 
    
    elif [ ! -e "$N247LAUNCH/launch.sh" ]; then

        log_msg "No launcher script, will init" 1
        make_launch init
    
    elif [ "$1" == "post" ];then

        if [ -e "$N247LAUNCH/launch.pst" ]; then
            log_msg "Adding Launcher Post Commands" 1    
            cat $N247LAUNCH/launch.pst >> $N247LAUNCH/launch.sh
        fi
    
    elif [ ! -z "$1" ]; then

        log_msg "Adding Launcher Command: $1" 0
        #echo "$1 2>$N247LAUNCH/launch.log" >> $N247LAUNCH/launch.sh
        #echo "$1 > /dev/null 2>&1" >> $N247LAUNCH/launch.sh
        echo "$1 > /dev/null 2>launch.log " >> $N247LAUNCH/launch.sh
        
        last_game="$game"
        last_emu="$console"
    fi

}

#n247 launch selection
function launch_selection()
{
    make_launch post
    clear_screen
    #sh "$N247LAUNCH/launch.sh" 2>> "$N247LAUNCH/launch.log"
    $N247LAUNCH/launch.sh #> /dev/null 2>&1
    log_msg "launch_selection : launching game $game with emu $console." 0
}

#n247 only kill if running
function kill_running(){
    if [ "$(pgrep -x "$1")" ];
    then
        #log_msg "Killing off $1"
        killall $1
    fi
}

#n247 central rm file call that checks for files before deleting them
function rm_xist()
{
    if [ -e $1 ]; then
        log_msg "rm_xist : Deleting $1" 1
        rm $1
    fi

}

#n247 launcher log
function debug_launcher_result(){

    log_msg "debug_launcher_result : Lemonlauncher Result : $result" 1

}

function divide () {

    awk -v n1="$1" -v n2="$2" 'BEGIN { printf "%s", (n1 / n2) }'

}
function mult () {

    awk -v n1="$1" -v n2="$2" 'BEGIN { printf "%.0f", (n1 * n2) }'

}
function minus () {

    awk -v n1="$1" -v n2="$2" 'BEGIN { printf "%.2f", (n1 - n2) }'

}

function handle_wlan () {
    log_msg "handle_wlan : setup up wifi services" 0 
    cd /root
    netctl list > tmp/wlan_list.txt 


    if [ "$1" = "wifi_disable" ]; then
        log_msg "handle_wlan : wifi_disable was called" 1
        log_msg "handle_wlan : we now disable active network we find with netctl list" 1 
        if grep -q "* wlan" tmp/wlan_list.txt; then
            SSID=$(grep "* wlan" tmp/wlan_list.txt | cut -c 3-) > /dev/null 2>&1
            netctl stop "$SSID" > /dev/null 2>&1
            netctl disable "$SSID" > /dev/null 2>&1
            log_msg "handle_wlan : disabled wlan $SSID, see /etc/netctl" 0
        else
            log_msg "handle_wlan : No active wlan found" 1
            while read line_wlan 
            do 
                netctl stop "$line_wlan" 
                netctl disable "$line_wlan"
            done < tmp/wlan_list.txt
        fi


    else
        if grep -q "* wlan" tmp/wlan_list.txt; then
         
            SSID=$(grep "* wlan" tmp/wlan_list.txt | cut -c 3-) > /dev/null 2>&1
            log_msg "handle_wlan : we found ative wlan $SSID " 0
            
            if [ "$1" == "netctl_enable" ]; then
                #netctl enable "$SSID" > /dev/null 2>&1
                netctl enable "$SSID"
                sleep 3

                log_msg "handle_wlan : netctl enable $SSID" 0
            fi

            systemctl start smb >> log.txt
            log_msg "handle_wlan : samba started" 0

        else
            log_msg "handle_wlan : No active WLAN found" 0
            log_msg "handle_wlan : Disabling WLAN will save you 3 to 15 sec boot time!" 0
            #while read line 
            #do 
                #SSID=$(echo $line) > /dev/null 2>&1
                #netctl start "$SSID"
                #log_msg "netctl start $SSID" 0
                #log_msg "sorry, but netctl enable is buggy" 0

            #done < tmp/wlan_list.txt

        fi
    fi

    

}


function del_disp_advmame () {

    # delete display settings in advmame
    sed -i "/vertical*/d" "$ADVHOME/advmame.rc"
    sed -i "/vertical*/d" "$ADVHOME/advmame_lowres.rc"
    sed -i "/vertical*/d" "$ADVHOME/advmame_highres.rc"

}

#in lowres mode a optimized shell res can be used
function set_res_default ()
{

    if [ "$opt_cmdshell_res" == "Y" ]; then
        if [ "$RESMODE" == "LOW" ]; then
            log_msg "set_res_default : setting default low res" 0
            /opt/vc/bin/vcgencmd hdmi_timings 450 1 50 30 90 270 1 1 1 30 0 0 0 60 0 9600000 1 > /dev/null 
            tvservice -e  "DMT 87" > /dev/null
            fbset -g 450 270 450 270 24 > /dev/null
        fi
    fi 
}

# fetches now hdmi_timings from config.txt when lowres mode
function set_res_lemonlauncher ()
{
    if [ "$RESMODE" == "LOW" ]; then
        log_msg "set_res_lemonlauncher : setting lemonlauncher low res" 0
        #/opt/vc/bin/vcgencmd hdmi_timings 320 1 12 20 52 240 1 5 7 11 0 0 0 60 0 6400000 1 > /dev/null 

        grep hdmi_timings /boot/config.txt > /root/tmp/config_lowres.conf
        sed -i "/^#/d" /root/tmp/config_lowres.conf
        ll_res_tmp=$(grep -w -i "hdmi_timings" /root/tmp/config_lowres.conf | cut -d"#" -f1 |cut -d "=" -f2) > /dev/null 2>&1
        log_msg "set_res_lemonlauncher : found hdmi_timings $ll_res_tmp in config.txt and will use it for lemonlauncher" 0

        /opt/vc/bin/vcgencmd hdmi_timings $ll_res_tmp > /dev/null 

        tvservice -e  "DMT 87" > /dev/null
	    fbset -depth 8 && fbset -depth 24 -xres 320 -yres 240 > /dev/null
    fi
}

function handle_orientation () { 

    if [ "$ORIENTATION" == "H" ]; then
        log_msg "handle_orientation : Horizontal Screen is configured." 0

        
        sed -i "/display_ror/d" "$ADVHOME/advmame.rc"
        sed -i "/display_ror/d" "$ADVHOME/advmame_lowres.rc"
        sed -i "/display_ror/d" "$ADVHOME/advmame_highres.rc"
        sed -i "/display_rol/d" "$ADVHOME/advmame.rc"
        sed -i "/display_rol/d" "$ADVHOME/advmame_lowres.rc"
        sed -i "/display_rol/d" "$ADVHOME/advmame_highres.rc"
    
        if [ "$ORIENTATION_H" == "normal" ]; then
            log_msg "handle_orientation : Horizontal Screen in normal direction." 0
            log_msg "handle_orientation : rotation=0." 0
            rotation="0"

            # no entry for advmame.rc means normal orientation

            sed -i "/display_orientation*/d" "$ADVHOME/advmenu.rc"
            echo "display_orientation" >> "$ADVHOME/advmenu.rc"

            sed -i "/video_rotation*/d" "$retroarch_conf"
            echo "video_rotation = \"$rotation\" " >> "$retroarch_conf"

            sed -i "s/rotate.*/rotate = \"none\" /g" /root/.lemonlauncher/lemonlauncher.conf
            sed -i "s/rotate.*/rotate = \"none\" /g" /root/.lemonlauncher/lemonlauncher_template.conf


        else # flip
            log_msg "handle_orientation : Horizontal Screen in flipped direction." 0
            log_msg "handle_orientation : rotation=90." 0
            rotation="90"

            # no clue how to rotate screen in advmame 90degree.
            #echo "horizontal/display_ror yes" >> $ADVHOME/advmame.rc
            #echo "horizontal/display_ror yes" >> $ADVHOME/advmame_lowres.rc
            #echo "horizontal/display_ror yes" >> $ADVHOME/advmame_highres.rc
            sed -i "/video_rotation*/d" "$retroarch_conf"
            echo "video_rotation = \"$rotation\"" >> "$retroarch_conf"

            sed -i "s/rotate.*/rotate = \"flip\" /g" /root/.lemonlauncher/lemonlauncher.conf
            sed -i "s/rotate.*/rotate = \"flip\" /g" /root/.lemonlauncher/lemonlauncher_template.conf

        fi
    else

        log_msg "handle_orientation : Vertical Screen is configured." 0
        if [ "$ORIENTATION_V" == "left" ]; then
            log_msg "handle_orientation : Vertical Screen in normal direction." 0
            log_msg "handle_orientation : rotation=45." 0
            rotation="45"

            sed -i "/display_orientation*/d" "$ADVHOME/advmenu.rc"
            echo "display_orientation flip_xy mirror_y" >> "$ADVHOME/advmenu.rc"

            sed -i "/display_rol*/d" "$ADVHOME/advmame.rc"
            sed -i "/display_rol*/d" "$ADVHOME/advmame_lowres.rc"
            sed -i "/display_rol*/d" "$ADVHOME/advmame_highres.rc"
            echo "vertical/display_rol yes" >> $ADVHOME/advmame.rc
            echo "vertical/display_rol yes" >> $ADVHOME/advmame_lowres.rc
            echo "vertical/display_rol yes" >> $ADVHOME/advmame_highres.rc

            sed -i "/video_rotation*/d" "$retroarch_conf"
            echo "video_rotation = \"$rotation\"" >> "$retroarch_conf"

            sed -i "s/rotate.*/rotate = \"right\" /g" /root/.lemonlauncher/lemonlauncher.conf
            sed -i "s/rotate.*/rotate = \"right\" /g" /root/.lemonlauncher/lemonlauncher_template.conf


        else
            log_msg "handle_orientation : Vertical Screen in flipped direction." 0
            log_msg "handle_orientation : rotation=135." 0
            rotation="135"

          
            sed -i "/display_orientation*/d" "$ADVHOME/advmenu.rc"
            echo "display_orientation flip_xy mirror_y" >> $ADVHOME/advmenu.rc

            sed -i "/display_rol*/d" "$ADVHOME/advmame.rc"
            sed -i "/display_rol*/d" "$ADVHOME/advmame_lowres.rc"
            sed -i "/display_rol*/d" "$ADVHOME/advmame_highres.rc"

            echo "vertical/display_ror yes" >> $ADVHOME/advmame.rc
            echo "vertical/display_ror yes" >> $ADVHOME/advmame_lowres.rc
            echo "vertical/display_ror yes" >> $ADVHOME/advmame_highres.rc

            sed -i "/video_rotation*/d" "$retroarch_conf"
            echo "video_rotation = \"$rotation\"" >> "$retroarch_conf"
            
            sed -i "s/rotate.*/rotate = \"left\" /g" /root/.lemonlauncher/lemonlauncher.conf
            sed -i "s/rotate.*/rotate = \"left\" /g" /root/.lemonlauncher/lemonlauncher_template.conf

        fi
        
    fi 
}

# Since retroarch has dozen ways to introduce new 
# configs, we want to keep the user in the loop
# so we directly alter the retroarch.cfg 

function change_ra_param_set() {
    log_msg "change_ra_param_set : applying config file $1 in $retroarch_conf" 0
    while read line 
    do 
        param=$(echo $line | cut -d"=" -f1 | cut -d" " -f1) > /dev/null 2>&1
        value=$(echo $line | cut -d"=" -f2 | cut -d"\"" -f2) > /dev/null 2>&1
        if  [ ! -z "$param" ]; then 
            if [ ! "$param" = "#" ] ; then
                #log_msg "change_ra_param_set : call change_ra_param" 1
                change_ra_param "$param" "$value"
                log_msg "change_ra_param_set : $param = \"$value\"" 0
            fi
        fi
    done < $1


}
function change_ra_param() {
    # $1 = param
    # $2 = value

    if ! grep -q -w "$1 = \"$2\"" $retroarch_conf ; then
        sed -i "/"$1".*$/d" "$retroarch_conf" 2>&1
        echo -e ""$1" = \""$2"\"" >> "$retroarch_conf" 2>&1
        log_msg "change_ra_param : change retroarch $1 to $2" Â1
    #else
        #log_msg "$1 with $2 in retroarch already taken." 1
    fi

}


function get_rotation () {

    log_msg "get_rotation : get the rotation according game and selected modes"

    if [ "$ORIENTATION" == "H" ]; then
        if [ "$ORIENTATION_H" == "normal" ]; then
            log_msg "get_rotation : rotation=0." 0
            rotation="0"
        else # flip
            log_msg "get_rotation : rotation=90." 0
            rotation="90"
        fi
    else
        if [ "$ORIENTATION_V" == "left" ]; then
            log_msg "get_rotation : rotation=45." 0
            rotation="45"
        else
            log_msg "get_rotation : rotation=135." 0
            rotation="135"
        fi
    fi 
}

# params hdmi_timings #xres#xpos#yres#ypos
# TODO add overscan values here?

function set_res () 
{

  	log_msg "set_res for $1" 1
  	log_msg "hdmi_timings $1" 1
	log_msg "custom_viewport_width=$2" 1
	log_msg "custom_viewport_x=$3" 1
	log_msg "custom_viewport_height=$4" 1
	log_msg "custom_viewport_y=$5" 1

    /opt/vc/bin/vcgencmd hdmi_timings $1 > /dev/null

    tvservice -e "DMT 87" > /dev/null
    fbset -depth 8 && fbset -depth 16 -xres $2 -yres $4 > /dev/null
    
    change_ra_param "custom_viewport_width" "$2"
    change_ra_param "custom_viewport_x" "$3"
    change_ra_param "custom_viewport_height" "$4"
    change_ra_param "custom_viewport_y" "$5"
 
}

# $1 is the core name
# file databases/custom_resolution.txt

function read_custom_res()
{

    log_msg "read_custom_res : Reading system $1 default resolution from databases/custom_resolution.txt" 0

    # failure if a single value is missing must be also covered
    # so we declare default values
    xres="320"
    yres="228"
    freq="60"

    system=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f2`
    emu_type=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f3`

    log_msg "read_custom_res : core $1" 0
    log_msg "read_custom_res : system $system" 0
    log_msg "read_custom_res : emu_type $emu_type" 0


    if [ "$emu_type" = "console" ] || [ "$emu_type" = "arcade" ]; then
        log_msg "read_custom_res : $1 is a retroarch arcade or console core according custom_resolution.txt." 0 
    
        log_msg "read_custom_res : Found default resolution for arcade or console cores." 0 

        xres=`grep -w "$1" $database/custom_resolutions.txt | cut -d" " -f1`
        yres=`grep -w "$1" $database/custom_resolutions.txt | cut -d" " -f2`
        freq=`grep -w "$1" $database/custom_resolutions.txt | cut -d" " -f3`
        log_msg "read_custom_res : xres $xres" 0
        log_msg "read_custom_res : yres $yres" 0
        log_msg "read_custom_res : freq $freq" 0

    else    

        log_msg "read_custom_res : system $1 is not a retroarch core. Handle own resolution settings" 0

        emu_type=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f7`
        system=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f6`
        custom_res=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f1`
        xres=`grep -w "$1" $database/custom_resolutions.txt | cut -d" " -f1`
        yres=`grep -w "$1" $database/custom_resolutions.txt | cut -d" " -f6`
        ra_xres=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f2`
        ra_xpos=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f3`
        ra_yres=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f4`
        ra_ypos=`grep -w "$1" $database/custom_resolutions.txt | cut -d"#" -f5`


        log_msg "read_custom_res : read custom resolution settings for system $1" 0
        log_msg "read_custom_res : xres $xres" 0
        log_msg "read_custom_res : yres $yres" 0
        log_msg "read_custom_res : yres $yres" 0
        log_msg "read_custom_res : custom_res $custom_res" 0

        log_msg "read_custom_res : the ra settings are now more a framebuffer setting $1" 0
        log_msg "read_custom_res : ra_xres $ra_xres" 0
        log_msg "read_custom_res : ra_xpos $ra_xpos" 0
        log_msg "read_custom_res : ra_yres $ra_yres" 0
        log_msg "read_custom_res : ra_ypos $ra_ypos" 0

    fi        
    
    log_msg "read_custom_res : done" 0

}

#param rom name
#file needed is databases/arcade_res_table.txt

function get_rom_resolution ()
{
    log_msg "get_rom_resolution : Getting the rom resolution from databases/arcade_res_table.txt" 0


    rom_resolution=`grep "^$game;" $database/arcade_res_table.txt | cut -d";" -f3 `
    rom_width=`echo $rom_resolution | cut -d"x" -f1`
    rom_height=`echo $rom_resolution | cut -d"x" -f2 | cut -d"@" -f1`
    rom_freq=`echo $rom_resolution |  cut -d"x" -f2 | cut -d"@" -f2`

    log_msg "get_rom_resolution : for arcade rom $game" 0
    log_msg "get_rom_resolution : rom_resolution is $rom_resolution" 0
    log_msg "get_rom_resolution : rom_width is $rom_width" 0
    log_msg "get_rom_resolution : rom_height is $rom_height" 0
    log_msg "get_rom_resolution : rom_freq is $rom_freq" 0

    if [ "$rom_resolution" == "" ]; then
        log_msg "get_rom_resolution : Found no rom resolution for $game." 0
        log_msg "get_rom_resolution : Taking default values 320x228@60" 0
        #rom_width="320"
        #rom_height="228"
        #rom_freq="60"

    fi
    # failure if a single value is missing are also covered
    if [ "$rom_width" == "" ]; then
        log_msg "get_rom_resolution : Found no rom_width for $game. Setting to 320" 0

        rom_width="320"
    fi
    if [ "$rom_height" == "" ]; then
        log_msg "get_rom_resolution : Found no rom_height for $game. Setting to 228" 0

        rom_height="228"
    fi
    if [ "$rom_freq" == "" ]; then
        log_msg "get_rom_resolution : Found no rom_freq for $game. Setting to 60" 0

        rom_freq="60"
    fi
    log_msg "get_rom_resolution : done" 0

    
}

# param core name
function set_custom_res () {
    log_msg "set_custom_res: core $1" 0

    log_msg "set_custom_res : call read_custom_res" 0
    read_custom_res "$1"

    log_msg "set_custom_res: read custom res for $1" 0
    log_msg "set_custom_res: found $custom_res" 0

    log_msg "set_custom_res : call set_res" 0
    set_res "$custom_res" "$ra_xres" "$ra_xpos" "$ra_yres" "$ra_ypos"
    log_msg "set_custom_res : done" 0

    
}


function call_compute_res ()
{
    cd resolution
    log_msg "call_compute_res: xres $1" 0
    log_msg "call_compute_res: yres $2" 0
    log_msg "call_compute_res: freq $3" 0
    log_msg "call_compute_res: rotation $4" 0
    
    log_msg "call_compute_res: launch res via compute_res_cmd.py" 0
    # there was an issue that game.cfg was not overwritten, so we do the job
    rm_xist game.cfg
    python3 compute_res_cmd.py $1 $2 $3 $4 > /dev/null 2>&1

    #if [ -f game.cfg ]; then 
        log_msg "call_compute_res: game.cfg found, apply to retroarch.cfg" 0
        log_msg "call_compute_res: call change_ra_param_set" 0
        change_ra_param_set "game.cfg"
    #else
    #    log_msg "call_compute_res: game.cfg not found" 0
    #    log_msg "call_compute_res: puh, this not good, dont know what to do." 0
    #    log_msg "call_compute_res: Ah, I know we take the standard ones." 0
    #   set_ra_res
    #    #test
    #fi
    cd /root

}
############################################################
# function launch_resolution
#
# param $1 is the core name 
#
############################################################

function launch_resolution ()
{
    log_msg "launch_resolution : Launch resolution for core $1" 0

    if [ "$CUSTOMRESMODE" == "Y" ]; then
        log_msg "launch_resolution : Custom Res is enabled." 0
 
        if [ "$RESMODE" == "LOW" ]; then
            log_msg "launch_resolution : res mode is low." 0

            #TODO 
            # purpose is to get the information if we now
            # deal with arcade emu_type cores or not. Based on this 
            # information we get rom res or consoles res
            log_msg "launch_resolution : call read_custom_res." 0
            read_custom_res $1
            
            # no valid resolution for requested core found, set back to default 320 x 240    
            if [ "$emu_type" = "" ]; then
                log_msg "launch_resolution : no valid custom resolution found for core $1" 0
                log_msg "launch_resolution : Using lemonlauncher resolution as fallback." 0
                log_msg "launch_resolution : call set_custom_res." 0
                set_custom_res "lemonlauncher"

            else 
                log_msg "launch_resolution : $xres $yres $freq for core $1 was found" 0
   
                # console handling
                if [ "$emu_type" == "console" ]; then
                    # jaaaaaa, wasn mit rotation.???? Wo kommt die denn her
                    log_msg "launch_resolution : call call_compute_res" 0
                    call_compute_res $xres $yres $freq $rotation
                        
                elif [ "$emu_type" == "arcade" ]; then    

                    log_msg "launch_resolution : Arcade core found, use rom res!" 0
                    log_msg "launch_resolution : call set_arcade_resolution, core res will be overriden." 0
                    set_arcade_resolution
            
                else
                    log_msg "launch_resolution : handle other stuff like shell etc" 0
                    log_msg "launch_resolution : call set_res for core $1" 0
                    set_res "$custom_res" "$ra_xres" "$ra_xpos" "$ra_yres" "$ra_ypos"               
                fi
            fi
            log_msg "launch_resolution : finished lowres resolution for core $1" 0
        #highres resolution
        else
            log_msg "launch_resolution : launch_resolution for highres mode for core $1 and $game" 0

            # rewrite default settings for retroarch not needed
            # all user configuration will be overwritten
            # and we do not want this
            #log_msg "launch_resolution : call set_ra_res, but why?" 0
            #set_ra_res
            
            #debug lowres
            log_msg "launch_resolution : debugging lowres in highres mode" 1
            if [ "$DEBUG" == "Y" ]; then
                log_msg "launch_resolution : call read_custom_res" 1            
                read_custom_res $1
            fi
            log_msg "launch_resolution : emu_type is $emy_type" 1
            log_msg "launch_resolution : core is $core" 1
            log_msg "launch_resolution : system is $system" 1
        fi
    # no custom_res
    else
        log_msg "launch_resolution : no custom resolution!" 0
        if [ "$RESMODE" == "LOW" ]; then
            log_msg "launch_resolution : call set_custom_res with lemonlauncher resolution!" 0
            set_custom_res "lemonlauncher"
        fi
    fi
    clear_screen
    log_msg "launch_resolution : done" 0
}


###############################################
# files needed resolution.ini
#
###############################################

function set_arcade_resolution() {

    log_msg "set_arcade_resolution : Getting the rom resolution of game $game." 0
    log_msg "set_arcade_resolution : call get_rom_resolution" 0
    get_rom_resolution

    # check for vertical game
    if grep -q -w "$game" $database/vertical.txt ; then 
        log_msg "set_arcade_resolution : $game is a vertical game.." 0

        #########TEST 10.01.2019 
        # test case. The scripts compute_res_cmd writes game.cfg that 
        # is written into retroarch.cfg-
        # this function here uses own retroarch overwrite. 
        
        if [ "$ORIENTATION" == "H" ]; then
            
            if [ "$auto_turn_screen" == "N" ]; then

                # we just put a guessed resolution for vertical games 
                # on horizontal screens
                #read_custom_res "vertical_default"
                log_msg "set_arcade_resolution : .. and you want to play on horizontal screen. Expect nothing!" 0
                   
                if [ $rom_width == "448" ]; then
                    rom_width="224"
                elif [ $rom_width == "376" ]; then
                    rom_width="230"
                elif [ $rom_width == "360" ]; then
                    rom_width="230"
                elif [ $rom_width == "288" ]; then
                    rom_width="238"
                else
                    #rom_width="256"
                    rom_width="228"
                fi 

                rom_width="224"

                log_msg "set_arcade_resolution : call call_compute_res" 0
                call_compute_res 1600 $yres 60 $rotation

                # new settings
                # ok, we have resolved above bug with vertical settings, 
                # we can use game.cfg
                
                #change_ra_param "video_scale_integer" "false"
                #change_ra_param "aspect_ratio_index" "22"
                #change_ra_param "video_smooth" "false"
                #change_ra_param "video_threaded" "false"
                #change_ra_param "crop_overscan" "false"

                #change_ra_param "video_smooth" "true"
                ## due to rotated reso use rom_width for screen_heigth
                ##set_res "$custom_res" "$ra_xres" "$ra_xpos" "$rom_width" "$ra_ypos"
                ##
                # okok, we still need this
                log_msg "set_arcade_resolution : call change_ra_param" 0

                change_ra_param "custom_viewport_width" "1120"
                change_ra_param "custom_viewport_x" "240"
                change_ra_param "custom_viewport_height" "$rom_width"
                change_ra_param "custom_viewport_y" "8"
            
            else # auto_turn_screen
                log_msg "set_arcade_resolution : turn screen vertical, gpio 26 on" 0

                # cool, so you have a automatic turning screen!
                python3 /root/scripts/gpio_26_on.py

                log_msg "set_arcade_resolution : call call_compute_res" 0
                call_compute_res $rom_width $rom_height $rom_freq 45
                log_msg "set_arcade_resolution : call change_ra_param_set" 0
                change_ra_param_set "resolution/game.cfg"

            
            fi
            
            return 
        else 
            # situation: Game is vertical, screen is vertical

            log_msg "set_arcade_resolution : and screen is vertical. Nice setup!" 0
            log_msg "set_arcade_resolution : call call_compute_res" 0
            call_compute_res $rom_width $rom_height $rom_freq $rotation

        fi
    else # horizontal game
        log_msg "set_arcade_resolution : You are playing a horizontal game.. $game" 0

        log_msg "set_arcade_resolution : call call_compute_res" 0
        call_compute_res $rom_width $rom_height $rom_freq $rotation

    fi


}

function show_mode ()
{
    text=" ORIENTATION =  $ORIENTATION"
    text="$text\n MODE = $MODE" 
    text="$text\n PI2SCART = $PI2SCART" 
    text="$text\n CUSTOMRESMODE = $CUSTOMRESMODE" 
    text="$text\n AUDIOMODE = $AUDIOMODE "
    text="$text\n FAVOURITESMODE = $FAVOURITESMODE" 
    text="$text\n HISTORYMODE = $HISTORYMODE "
    text="$text\n USBSTICK = $USBSTICK"
    text="$text\n RESMODE = $RESMODE"
    text="$text\n ORIENTATION_V = $ORIENTATION_V"
    text="$text\n ORIENTATION_H = $ORIENTATION_H"
    text="$text\n SHOWPARENTS = $SHOW_PARENTS"
    text="$text\n BUTTONLAYOUT = $BUTTONLAYOUT"
    text="$text\n USB GAMEPAD = $USB_GAMEPAD"
    text="$text\n CRT Profile = $SCREEN_PROFILE"
    text="$text\n Auto Turn Screen = $auto_turn_screen"
    text="$text\n work_dir = $work_dir"
    text="$text\n config_file = $config_file"
    whiptail_msgbox "Show Mode" "$text" 25 60
}

##################################################
# Could be optimized for time performance
#
##################################################

function set_config_param() {

    param=$1
    old_value=$2
    new_value=$3
    
    if grep -q "$param=\"$old_value\"" $config_file; then  
        sed -i "s/$param=\"$old_value\"/$param=\"$new_value\"/" $config_file
        log_msg "set_config_param : set $param to $new_value" 0
    fi

}

function set_mode()
{
    old_text=$1
    new_text=$2
    param=$3
    old_value=$4
    new_value=$5
    if [ -f .lemonlauncher/games.conf ] ; then
        if grep -q "$old_text" .lemonlauncher/games.conf; then
            sed -i "s/title = \"$old_text\"/title = \"$new_text\"/" .lemonlauncher/games.conf
        fi
    fi 
    if grep -q "$old_text" frontend/options.conf; then  
        sed -i "s/title = \"$old_text\"/title = \"$new_text\"/" frontend/options.conf
    fi
    if grep -q "$old_text" frontend/gamelists.conf; then  
        sed -i "s/title = \"$old_text\"/title = \"$new_text\"/" frontend/gamelists.conf
    fi
    if grep -q "$param=\"$old_value\"" $config_file; then  
        sed -i "s/$param=\"$old_value\"/$param=\"$new_value\"/" $config_file
        log_msg "set_mode : set $param to $new_value" 0
    fi
    log_msg "set_mode : set $param to $new_value" 1

}

function read_config_files ()
{
    # Look first for config file in boot folder

    config_file="$USB_PATH/regamebox.conf"
    config_folder="$USB_PATH"

    if [ ! -e "$config_folder" ]; then
    	config_file="/boot/regamebox.conf"
        config_folder="/boot"
        log_msg "read_config_files : Using regamebox.conf in boot folder" 0
    else
        log_msg "read_config_files : Using regamebox.conf on usb stick" 0
    fi

    source $config_file
    # 
    if [ "$RESMODE" == "LOW" ]; then
        source $config_folder/retroarch_lowres.conf
        log_msg "read_config_files : Reading default retroarch lowres settings from $config_folder/retroarch_lowres.conf" 0
    else
        source $config_folder/retroarch_highres.conf
        log_msg "read_config_files : Reading default retroarch highres settings $config_folder/retroarch_highres.conf" 0
    fi

    # this is needed to take account for manual editing of config file

    if [ "$AUTOSTART" == "1" ]; then
        set_mode "Turn Autostart On" "Turn Autostart Off" "AUTOSTART" "0" "1"
    else
        set_mode "Turn Autostart Off" "Turn Autostart On" "AUTOSTART" "1" "0"
    fi

    if [ "$ORIENTATION" == "H" ]; then
        set_mode "Switch to Horizontal Screen" "Switch to Vertical Screen" "ORIENTATION" "V" "H"
    else
        set_mode "Switch to Vertical Screen" "Switch to Horizontal Screen" "ORIENTATION" "H" "V"
    fi

    # if pi2scart auto then get automatic setup
    if [ "$PI2SCART" == "A" ]; then
        log_msg "read_config_file : Automatic check if pi2scart or pi2jamma is installed" 0 
        log_msg "read_config_file : turn pi2jamma driver on to see if unwanted key presses comes." 0 
        pikeyd165_start
        #sleep 0.5
        sleep 1
        python3 /root/scripts/check_pi2jamma.py > /root/tmp/check_pi2jamma.txt
        tmp_check=`cat /root/tmp/check_pi2jamma.txt`
        # &&& are printed
        # pi2jamma hardware not found
        if [ "$tmp_check" == "0" ]; then
            PI2SCART="Y"
            pikeyd165_stop
        else 
            PI2SCART="N"
        fi
        log_msg "read_config_files : Auto config pi2scart=$PI2SCART" 0
            
    # otherwise let user decide
    else
        if [ "$PI2SCART" == "Y" ]; then
            set_mode "Switch to Pi2SCART" "Switch to Pi2JAMMA" "PI2SCART" "N" "Y"
        else 
            set_mode "Switch to Pi2JAMMA" "Switch to Pi2SCART" "PI2SCART" "Y" "N"
        fi
    fi


    if [ "$CUSTOMRESMODE" == "Y" ]; then
        set_mode "Turn Custom Res On" "Turn Custom Res Off" "CUSTOMRESMODE" "N" "Y"
    else 
        set_mode "Turn Custom Res Off" "Turn Custom Res On" "CUSTOMRESMODE" "Y" "N"
    fi

    if [ "$FAVOURITESMODE" == "Y" ]; then
        set_mode "Turn Favourites Menu On" "Turn Favourites Menu Off" "FAVOURITESMODE" "N" "Y"
    else 
        set_mode "Turn Favourites Menu Off" "Turn Favourites Menu On" "FAVOURITESMODE" "Y" "N"                
    fi

    if [ "$HISTORYMODE" == "Y" ]; then
        set_mode "Turn History Menu On" "Turn History Menu Off" "HISTORYMODE" "N" "Y"
    else 
        set_mode "Turn History Menu Off" "Turn History Menu On" "HISTORYMODE" "Y" "N"
    fi

    if [ "$AUDIOMODE" == "Y" ]; then
        set_mode "Turn Music On" "Turn Music Off" "AUDIOMODE" "N" "Y"
    else 
        set_mode "Turn Music Off" "Turn Music On" "AUDIOMODE" "Y" "N"
    fi

    if [ "$RESMODE" == "HIGH" ]; then
        set_mode "Switch to High Res" "Switch to Low Res" "RESMODE" "LOW" "HIGH"
    else 
        set_mode "Switch to Low Res" "Switch to High Res" "RESMODE" "HIGH" "LOW"
    fi

    if [ "$CONFMODE" == "1" ]; then
        set_mode "Switch To Extended Config" "Switch To Simple Config" "CONFMODE" "0" "1"
    else
        set_mode "Switch To Simple Config" "Switch To Extended Config" "CONFMODE" "1" "0"
    fi

    if [ "$SHOW_PARENTS" == "Y" ]; then
        set_mode "Show Only Parents" "Show Full List" "SHOW_PARENTS" "N" "Y"
    else 
        set_mode "Show Full List" "Show Only Parents" "SHOW_PARENTS" "Y" "N"
    fi

    if [ "$BUTTONLAYOUT" == "3" ]; then
        sed -i "s/  game { rom =\"buttonlayout\".*$/  game { rom =\"buttonlayout\" title = \"Switch to 4 Buttons\" params=\"buttonlayout\" }/" frontend/options.conf
    elif [ "$BUTTONLAYOUT" == "4" ]; then
        sed -i "s/  game { rom =\"buttonlayout\".*$/  game { rom =\"buttonlayout\" title = \"Switch to 6 Buttons\" params=\"buttonlayout\" }/" frontend/options.conf
    else 
        sed -i "s/  game { rom =\"buttonlayout\".*$/  game { rom =\"buttonlayout\" title = \"Switch to 3 Buttons\" params=\"buttonlayout\" }/" frontend/options.conf
    fi


}

# set remaps for lr-fbalpha to yes or no. 
# you want no for gamepads

function set_remap ()
{
    if [ $REMAP_FBA == "N" ]; then
        log_msg "set_remap : set remap_fba no" 0
        if [ -e "$retroarch_folder/config/remaps/FB Alpha" ]; then
            log_msg "set_remap : remap dir found and rename it" 0

            mv $retroarch_folder/config/remaps/FB\ Alpha $retroarch_folder/config/remaps/FB\ Alpha_  > /dev/null 2>&1
        fi
    else
        log_msg "set_remap : set remap_fba yes" 0

        if [ -e "$retroarch_folder/config/remaps/FB Alpha_" ]; then
            log_msg "remap backup dir found and activate it" 0

            mv $retroarch_folder/config/remaps/FB\ Alpha_ $retroarch_folder/config/remaps/FB\ Alpha > /dev/null 2>&1
        fi
    fi

}

function set_work_dir ()
{
    log_msg "set_work_dir : Setting the working dirs in the various config files." 0
    cd /root
    if [ $USBSTICK == "Y" ]; then
        
        console_roms="$USB_PATH/roms"
        work_dir="$USB_PATH"
	
        sed -i "s/home\/x/mnt\/sda/g" .advance/advmame.rc
    	sed -i "s/home\/x/mnt\/sda/g" .lemonlauncher/lemonlauncher.conf
    	sed -i "s/home\/x/mnt\/sda/g" .lemonlauncher/lemonlauncher_template.conf
    else
        console_roms="$SD_PATH/roms"
        work_dir="$SD_PATH"
    	sed -i "s/mnt\/sda/home\/x/g" .advance/advmame.rc
	    sed -i "s/mnt\/sda/home\/x/g" .lemonlauncher/lemonlauncher.conf
	    sed -i "s/mnt\/sda/home\/x/g" .lemonlauncher/lemonlauncher_template.conf
    fi
    log_msg "set_work_dir : Console ROM dir is `echo $console_roms`" 0
    log_msg "set_work_dir : Work dir is `echo $work_dir`" 0
}


function pikeyd165_start ()
{
    pikeyd165_stop
    if [ "$PI2SCART" == "Y" ]; then    
        log_msg "pikeyd165_start : didn't started pikeyd165, because pi2scart is active!" 0
    else 
        pikeyd165 -smi -ndb -d &> /dev/null
        log_msg "pikeyd165_start : Started pikeyd165, pi2jamma is active!" 0
    fi
}

function pikeyd165_stop ()
{
    # do not take care about pi2scart. Better to stop pikeyd165 once more  
    pikeyd165 -k &> /dev/null
    #killall pikeyd165
    kill_running pikeyd165
    log_msg "pikeyd165_stop : Kill pikeyd165" 0
}


#######################################################
##### check if ll is already running #####
#######################################################

function check_running ()
{
	RUNNING=`ps x|grep lemonlauncher |wc -l`
	if [ "$RUNNING" -gt "1" ]; then
	    echo "already running"
	    exit 0
	fi

	#for tty in /dev/tty?; do /usr/bin/setleds -D +num < "$tty"; done
	#exit 0
	#source /etc/profile	
	clear_screen
}

function init_regamebox() {

    PI2SCART_OLD=$PI2SCART
    pikeyd165_stop
    cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
    cp /etc/pikeyd165_whiptail.conf /etc/pikeyd165.conf
    pikeyd165_start

    whiptail --title "First Start of Regambox" --menu "Step - Select Hardware" 20 40 2 \
        pi2scart "Pi2scart" \
        pi2jamma "Pi2jamma" 2>/root/tmp/choice.txt

    HARDWARE=$(</root/tmp/choice.txt)
    log_msg "init_regamebox : Hardware $HARDWARE was selected." 0


	if [ "$HARDWARE" = "pi2scart" ]; then
        log_msg "pi2scart" 0
        set_config_param "PI2SCART" "$PI2SCART_OLD" "N"
        
        select_usb_gamepad

	elif [ "$HARDWARE" = "pi2jamma" ]; then
        log_msg "init_regamebox : pi2jamma" 0
        set_config_param "PI2SCART" "$PI2SCART_OLD" "N"

    else 
        log_msg "init_regamebox : Abort selection, default" 0
        whiptail --title "Default" --msgbox "Initialization aborted, taking pi2jamma settings" 10 40
        set_config_param "PI2SCART" "$PI2SCART_OLD" "$PI2SCART"
    fi

    set_config_param "INIT_REGAMEBOX" "Y" "N"
    INIT_REGAMEBOX="N"

    pikeyd165_stop
    cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
    pikeyd165_start
    clear_screen



}
function usb_gamepad_wizard () {
    log_msg "usb_gamepad_wizard : set usb gamepad" 0

    USB_GAMEPAD_OLD=$USB_GAMEPAD
    /root/scripts/joy_wizard/joy_wizard
    cp /root/config/lemonlauncher_custom_usb.conf /root/.lemonlauncher/lemonlauncher_custom_usb.cfg 
    USB_GAMEPAD="custom_usb"
    set_config_param "USB_GAMEPAD" "$USB_GAMEPAD_OLD" "$USB_GAMEPAD"
    handleUsbGamepad
}


function select_usb_gamepad() {
    log_msg "select_usb_gamepad : select usb gamepad" 0

    USB_GAMEPAD_OLD=$USB_GAMEPAD

    pikeyd165_stop
    cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
    cp /etc/pikeyd165_whiptail.conf /etc/pikeyd165.conf
    pikeyd165_start


    whiptail --title "Select USB Gamepad" --menu "Select USB Gamepad" 20 60 5 \
        nousb "No Gamepad, Keyboard" \
        xinmo_2p "XinMotek 2 Player PCB" \
        snes_usb "SNES USB Gamepad" \
        ps3 "Playstation 3 Pad" \
        xboxone "Xbox One Pad" \
        xbox360 "xbox360" 2>/root/tmp/choice.txt

    USB_GAMEPAD=$(</root/tmp/choice.txt)
    log_msg "select_usb_gamepad : USB Gamepad $USB_GAMEPAD was selected." 0

    #TODO automatic pi2jamma mode 

	if [ "$USB_GAMEPAD" = "" ]; then
        log_msg "select_usb_gamepad : Abort selection, no change" 0
        USB_GAMEPAD=$USB_GAMEPAD_OLD
    else 
        set_config_param "USB_GAMEPAD" "$USB_GAMEPAD_OLD" "$USB_GAMEPAD"
    fi
    handleUsbGamepad

    pikeyd165_stop
    cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
    pikeyd165_start
    clear_screen

}

function select_crt_profile() {
    log_msg "select_crt_profile : old value is $SCREEN_PROFILE" 0 

    SCREEN_PROFILE_OLD=$SCREEN_PROFILE

    pikeyd165_stop
    cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
    cp /etc/pikeyd165_whiptail.conf /etc/pikeyd165.conf
    pikeyd165_start

    whiptail --title "Screen Calibraton Profile" --menu "Screen Calibraton Profile" 20 60 4 \
        custom "Custom CRT Profile" \
        consumer "Consumer CRT Profile" \
        sony "Sony PVM BVM CRT Profile" \
        arcade "Arcade CRT Profile" 2>/root/tmp/choice.txt

    SCREEN_PROFILE=$(</root/tmp/choice.txt)

    log_msg "select_crt_profile : Screen Profile $SCREEN_PROFILE was selected." 0


	if [ "$SCREEN_PROFILE" = "custom" ]; then
	    log_msg "select_crt_profile : Custom Screen Profile copied to calibration.conf"Ã0
        #cp /root/config/screens/calibration_base.conf /root/resolution/calibration.conf
        whiptail --title "Custom Screen Profile" --msgbox "Set custom crt calibration in Options - Screen - Calibrate Screen" 10 40
        set_config_param "SCREEN_PROFILE" "$SCREEN_PROFILE_OLD" "$SCREEN_PROFILE"

    elif [ "$SCREEN_PROFILE" = "consumer" ]; then
	    log_msg "select_crt_profile : Consumer Screen Profile copied to calibration.conf"Ã0
        cp /root/config/screens/consumer_crt_calibration.conf /root/resolution/calibration.conf
        set_config_param "SCREEN_PROFILE" "$SCREEN_PROFILE_OLD" "$SCREEN_PROFILE"

    elif [ "$SCREEN_PROFILE" = "sony" ]; then
	    log_msg "select_crt_profile : Sony PVM BVM Screen Profile copied to calibration.conf"Ã0
        cp /root/config/screens/sony_pvm_calibration.conf /root/resolution/calibration.conf
        set_config_param "SCREEN_PROFILE" "$SCREEN_PROFILE_OLD" "$SCREEN_PROFILE"

    elif [ "$SCREEN_PROFILE" = "arcade" ]; then
	    log_msg "select_crt_profile : Arcade Screen Profile copied to calibration.conf"Ã0
        cp /root/config/screens/arcade_crt_calibration.conf /root/resolution/calibration.conf
        set_config_param "SCREEN_PROFILE" "$SCREEN_PROFILE_OLD" "$SCREEN_PROFILE"
    fi
    

    pikeyd165_stop
    cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
    pikeyd165_start
    clear_screen

}

# Parameter $1 title of box
# Parameter $2 text of box
# Parameter $3 heigth
# Parameter $4 width
function whiptail_msgbox ()
{
    pikeyd165_stop
    cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
    cp /etc/pikeyd165_whiptail.conf /etc/pikeyd165.conf
    pikeyd165_start

    whiptail --title "$1" --msgbox "$2" $3 $4

    pikeyd165_stop
    cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
    pikeyd165_start
    clear_screen
    
}

# Parameter $1 title of box
# Parameter $2 text of box
# Parameter $3 heigth
# Parameter $4 width
function whiptail_yesno ()
{

    if [ "$PI2SCART" == "N" ]; then

        pikeyd165_stop
        cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
        cp /etc/pikeyd165_whiptail.conf /etc/pikeyd165.conf
        pikeyd165_start
    fi

    if (whiptail --title "$1" --yesno "$2" $3 $4) then
        whiptail_return="yes"
    else
        whiptail_return="no"
    fi

    if [ "$PI2SCART" == "N" ]; then

        pikeyd165_stop
        cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
        pikeyd165_start
    fi 
    
    clear_screen
}

#######################################################
##### Mount USB Stick #####
#######################################################

function mount_usb_stick ()
{
    log_msg "mount_usb_stick : " 0

	#is usb stick attached
	test=`dmesg |grep sda1|wc -l`
	if [ "$test" -gt "0" ]; then
		mount /dev/sda1 /mnt/sda &> /dev/null
		# test this
		USBSTICK="Y"
		log_msg "mount_usb_stick : USB stick found" 0
        if [ -e "$USB_PATH" ]; then
            touch $USB_PATH/test
            if ! [ -f "$USB_PATH/test" ]; then
                USBSTICK="N"
	            work_dir="$SD_PATH"
      
	            log_msg "mount_usb_stick : USB stick dir rpi2jamma found" 0
	            log_msg "mount_usb_stick : but can NOT write to usb stick" 0
                whiptail --infobox "Can't write to USB Stick.\n Using sdcard $work_dir" 20 40
                sleep 3
                clear_screen
            else
                rm $USB_PATH/test
                USBSTICK="Y"
	            work_dir="$USB_PATH"
	            log_msg "mount_usb_stick : valid USB stick dir rpi2jamma found, jippieh" 0
            fi 
        else
    	    USBSTICK="Y"
      		work_dir="$SD_PATH"
            USBSTICK_INIT="valid"


        fi
	else
		log_msg "mount_usb_stick : NO USB stick found, using SD Card" 0 
		USBSTICK="N"
		work_dir="$SD_PATH"
	fi

}

function generate_USB_folder_startup()
{

    if [ "$USBSTICK_INIT" == "valid" ] && [ "$USBSTICK" == "Y" ]; then

        log_msg "generate_USB_folder_startup : No valid regamebox folder found on USB Stick!" 0
    	text="No valid regamebox folders found on USB stick."
        text="$text\nUsing sd card $SD_PATH as rom folder."
        text="$text\n\nYou might want to :"
        text="$text Generate USB Stick Folders"
        whiptail_yesno "NO VALID USBSTICK" "$text" 15 40 

        if [ "$whiptail_return" == "yes" ]; then
            log_msg "generate_USB_folder_startup : Generate USB Stick folders while startup menu." 0
            sh /root/scripts/init_usbstick.sh $BASE_FOLDER
            text="Thanks for waiting."
            text="$text\n\n Copy now your roms to the USB Stick."
            text="$text\n\n Your system will be rebooted."
            whiptail --infobox "$text" 25 40
            #work_dir="$USB_PATH"
    	    #USBSTICK="Y"
            sleep 10
    	    reboot
        else
            log_msg "generate_USB_folder_startup : USER Abort, NO usb stick folders was generated" 0
      		work_dir="$SD_PATH"
    		USBSTICK="N"

        fi
    fi
}





#######################################################
##### Patch Handling #####
#
# if patch in patchdir with name patch_*.tgz then
# uncompress and copy
#######################################################
function patch_handling ()
{
    PATCHDIR=$work_dir

	if [ -d "$PATCHDIR" ]; then
        cd "$PATCHDIR"
        PATCHLIST=`ls | grep patch_ |grep -v done`
        for file in $PATCHLIST
    	    do
                echo "applying " $file
                ( cd / ; tar -xzvf $PATCHDIR/$file )
                pwd
                mv $file "$file"_done
                log_msg "patch_handling : patch "$file" installed" 0
	        done
    fi
}


#######################################################
# autostart function 
#
#######################################################
function check_autostart ()
{
    if [ "$AUTOSTART" == "1" ]; then
        log_msg "check_autostart : autostart" 0
        #/root/scripts/autostart_game.sh
        cd /root
        
        result=`cat tmp/lastgame.txt |awk '{print $4 " " $3}'`
        emu=`echo $result|awk '{print $1}'`
        rom=`echo $result|awk '{print $2}'`
        game=`cat tmp/lastgame.txt |awk -F ";" '{print $2}'| cut -c 3-`
        game=`echo ${game%?}` 
        console=`cat tmp/lastgame.txt |awk -F ";" '{print $3}'`

        ####### LAUNCHER #######
        if  [ ! -z "$console" ] && [ ! -z "$game" ]; then
            log_msg "check_autostart : Launching $console $game" 0
            make_launch init
            LAUNCHFILE="\""$console_roms"/"$console"/"$game"\""
            #echo $LAUNCHFILE
            #sleep 5
            log_msg "check_autostart : launch retroarch core $console" 0 
            launch_retroarch_core "$console" "$LAUNCHFILE"
        fi

        if [ "$console" == "pifba" ]; then
            #cd $PIFBAHOME

            if [ "$CUSTOMRESMODE" = "Y" ]; then
                log_msg "check_autostart : pifba, check function set_videotiming" 1
                log_msg "todo : execute compute res" 0
            fi
            #pikeyd165_stop
            LAUNCHFILE=""$console_roms"/"$console"/"$game".zip"

            $PIFBAHOME/fba2x_1st $LAUNCHFILE
            #/usr/local/share/piFBA/fba2x_1st /mnt/sda/rpi2jamma/roms/pifba/$game.zip
            #/usr/local/share/piFBA/fba2x_1st $LAUNCHFILE
            log_msg "check_autostart : Launched piFBA $LAUNCHFILE" 0

        fi

        if [ "$console" == "advmame" ]; then
            log_msg "check_autostart : advmame $game" 0
            #make_launch "/root/local/bin/advmame38 -cfg $ADVHOME/advmame.rc "$game"
            make_launch "/root/local/bin/advmame38 $game"
            
            launch_selection

        fi

        
    fi

}

#######################################################
# Gamelister
# 
# console_games.conf - consoles games
# arcade_games.conf - arcade games
#######################################################
function makeGamesConf()
{
    log_msg "makeGamesConf : " 0
    
	cd /root/.lemonlauncher/

    rm_xist games.conf

	# concatenate all the lists
	# special handling advmame needed

    # if vertical then no console titles.
    if [ "$ORIENTATION" == "V" ]; then
        log_msg "makeGamesConf : vertical screen, no console titles." 0
        cat arcade_games.conf > games.conf
    else
        log_msg "makeGamesConf : horizontal screen, add console titles." 0

        cat arcade_games.conf console_games.conf > games.conf
    fi

	# adding favourites to the gameslist
	if [ "$FAVOURITESMODE" == "Y" ]; then
        log_msg "makeGamesConf : add favourites." 0

	    cat $work_dir/favourites.conf >> games.conf
	fi

	# adding history to the gameslist
	if [ "$HISTORYMODE" == "Y" ]; then
        log_msg "makeGamesConf : add history." 0

	    cat $work_dir/history.conf >> games.conf
	fi

	#adding config to the gameslist
    if [ "$MODE" == "admin" ]; then
        log_msg "makeGamesConf : admin mode, adding config menus." 0

	    if [ "$CONFMODE" == "1" ]; then
            cat /root/frontend/config.conf >> games.conf
        else
            cat /root/frontend/simple_config.conf >> games.conf  
        fi
    fi
        
    cd /root

    zeile=$(cat tmp/advmenu.tmp) > /dev/null 2>&1
    if ! grep -q "AdvMenu" .lemonlauncher/games.conf ; then
        log_msg "makeGamesConf : adding advmenu." 0

        sed -i "s/menu \"advmame\" {/menu \"advmame\" {\n$zeile/g" .lemonlauncher/games.conf
    fi
    log_msg "makeGamesConf : filter bin in core psx." 0
    sed -i "/.bin\".*;psx/d" .lemonlauncher/games.conf


}


function gamelister () 
{

    log_msg "gamelister : Generating game list" 0
    cd /root/gamelister_folder
    
    if [ "$SHOW_PARENTS" == "Y" ] ; then
        log_msg "gamelister : show only parents" 0
        ./gamelister $database/gamelists/mame_list_parents.csv $database/gamelists/mame_list_parents.csv $work_dir
        if [ "$SHOW_ALL" == "Y" ] ; then
            log_msg "gamelister : show all orientations" 0
            ./gamelister $database/gamelists/mame_list_parents_all_orientation.csv $database/gamelists/mame_list_parents_all_orientation.csv $work_dir

        fi
    else
        log_msg "gamelister : show full list" 0
        ./gamelister $database/gamelists/fba_list_full.csv $database/gamelists/mame_list_full.csv $work_dir
    fi
    cp arcade_games.conf /root/.lemonlauncher
    cp console_games.conf /root/.lemonlauncher
    cd /root
    log_msg "gamelister : call makeGamesConf" 0

    makeGamesConf
    log_msg "gamelister : Finished game list" 0

}

function hide_fav ()
{
    # delete favs in games.conf

    end_fav=$(grep -n "fav_tail" .lemonlauncher/games.conf_tmp | awk -F: '{print $1}')
    start_fav=$(grep -n "menu \"Favourites\"" .lemonlauncher/games.conf_tmp | awk -F: '{print $1}')
    sed -i "$start_fav,$end_fav d" .lemonlauncher/games.conf_tmp               

}

function show_fav ()
{
    rm_xist games.conf
    # add favourites.conf
    cat .lemonlauncher/games.conf_tmp $work_dir/favourites.conf > /root/tmp/games.conf_tmp
    cp /root/tmp/games.conf_tmp .lemonlauncher/games.conf_tmp

}

function hide_history ()
{
    # delete last history in games.conf
    #end_history=$(wc -l .lemonlauncher/games.conf | awk -F " " '{print $1}')

    end_history=$(grep -n "history_tail" .lemonlauncher/games.conf_tmp | awk -F: '{print $1}')
    start_history=$(grep -n "menu \"History\"" .lemonlauncher/games.conf_tmp | awk -F: '{print $1}')
    sed -i "$start_history,$end_history d" .lemonlauncher/games.conf_tmp               

}
function show_history ()
{
    #rm_xist games.conf
    # add new history.conf
    cat .lemonlauncher/games.conf_tmp $work_dir/history.conf > /root/tmp/games.conf_tmp
    cp /root/tmp/games.conf_tmp .lemonlauncher/games.conf_tmp

}

function set_ra_res () {

    log_msg "set_ra_res : setting retroarch resolution" 0
    log_msg "set_ra_res : custom_viewport_width $custom_viewport_width" 1
    log_msg "set_ra_res : custom_viewport_height $custom_viewport_height" 1
    log_msg "set_ra_res : custom_viewport_x $custom_viewport_x" 1
    log_msg "set_ra_res : custom_viewport_y $custom_viewport_y" 1
    log_msg "set_ra_res : video_scale_integer $video_scale_integer" 1
    log_msg "set_ra_res : aspect_ratio_index $aspect_ratio_index" 1
    log_msg "set_ra_res : video_smooth $video_smooth" 1
    log_msg "set_ra_res : video_threaded $video_threaded" 1
    log_msg "set_ra_res : crop_overscan $crop_overscan" 1

    change_ra_param "custom_viewport_width" "$custom_viewport_width"
    change_ra_param "custom_viewport_height" "$custom_viewport_height"
    change_ra_param "custom_viewport_x" "$custom_viewport_x"
    change_ra_param "custom_viewport_y" "$custom_viewport_y"

    change_ra_param "video_scale_integer" "$video_scale_integer"
    change_ra_param "aspect_ratio_index" "$aspect_ratio_index"
    change_ra_param "video_smooth" "$video_smooth"
    change_ra_param "video_threaded" "$video_threaded"
    change_ra_param "crop_overscan" "$crop_overscan"

    # hard coding, do not do
    #if [ "$RESMODE" == "HIGH" ]; then
    #if [ "$ORIENTATION" == "H" ]; then

        #change_ra_param "custom_viewport_width" "480"
        #change_ra_param "custom_viewport_height" "640"
        #change_ra_param "aspect_ratio_index" "21"
    #fi
    #fi



}


# ReGamebox can be used with 15Khz RGB (lowrez) 
# and higher resolutions (highres)
function handle_resmode ()
{
    log_msg "handle_resmode : Getting information if highres or lowres is used" 0

    if [ "$RESMODE" == "HIGH" ]; then 
        log_msg "handle_resmode : highres mode shall be used" 0

        rm_xist /root/tmp/toggle_lowres_done
        # prevents that themes will be overwritten each time.
        if [ -f /root/tmp/toggle_highres_done ]; then 
            log_msg "handle_resmode : Toggle highres was done already. Everything is fine" 0
        else
            log_msg "handle_resmode : Toggle to highres" 0

            cp $ADVHOME/advmame_highres.rc $ADVHOME/advmame.rc
            cp /boot/config_highres.txt /boot/config.txt
            cp /root/themes/splash/splash_highres.png /root/splash.png
            cp /root/themes/loadingen_highres.png /root/.lemonlauncher/loadingen.png
            cp /root/themes/themes_highres/turrican/* /root/.lemonlauncher
            cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf

            if [ "$ORIENTATION" == "H" ]; then 
                log_msg "handle_resmode : Call makeGamesConf" 0
                makeGamesConf
            fi
            
            # default settings for retroarch
            log_msg "handle_resmode : Call set_ra_res" 0
            set_ra_res

            touch /root/tmp/toggle_highres_done
            log_msg "handle_resmode : shutdown system to take highres setting." 0
            reboot
        fi
    #LOWRES    
    else
        rm_xist /root/tmp/toggle_highres_done
        # prevents that themes will be overwritten each time.
        if [ -f /root/tmp/toggle_lowres_done ]; then 
            log_msg "handle_resmode : Toggle lowres was done already" 1
        else
            log_msg "handle_resmode : Toggle to lowres" 0

            cp $ADVHOME/advmame_lowres.rc $ADVHOME/advmame.rc    
            cp /boot/config_lowres.txt /boot/config.txt
            cp /root/themes/splash/splash_lowres.png /root/splash.png
            cp /root/themes/loadingen_lowres.png /root/.lemonlauncher/loadingen.png
            #cp /root/themes/themes/turrican/* /root/.lemonlauncher
            cp /root/themes/themes/simple/* /root/.lemonlauncher
            #cp /root/themes/themes/pb_blue/* /root/.lemonlauncher
            if [ "$ORIENTATION" == "H" ]; then 
                log_msg "handle_resmode : Call makeGamesConf" 0
                makeGamesConf
            fi
            cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf

            log_msg "handle_resmode : Call set_ra_res" 0
            set_ra_res

            touch /root/tmp/toggle_lowres_done
            log_msg "handle_resmode : shutdown system to take lowres setting." 0
            reboot
        fi
    fi

}


function timer () {

    if [ "$DEBUG" == "T" ]; then
        after=$(date +%s.%N)
        value=$(minus "$after" "$2")        
        log_msg "timer : $1 took $value sec" 0
    fi

}

function launch_retroarch_core () {

    log_msg "launch_retroarch_core : folder $1 " 0

    system=$1     
    core=$(grep -w -i "$1" $database/emulators.conf | cut -d";" -f2) > /dev/null 2>&1
    log_msg "launch_retroarch_core : gather folder $1 in databases/emulators.conf and found matching core $core" 0
    
    if [ ! "$core" == "" ]; then
    
        if [ "$core" == "mame2003_plus_libretro.so" ]; then
            log_msg "launch_retroarch_core : mame2003_plus needs other launch command with zip suffix" 0
            rom_suffix=".zip"
        else 
            rom_suffix=""
        fi
        log_msg "launch_retroarch_core : call launch_resolution for $core" 0
        
        launch_resolution $core

        log_msg "launch_retroarch_core : call make_launch" 0

        if [ "$DEBUG" == "N" ]; then
            #make_launch "retroarch_176 -L $retroarch_cores/$core $2$rom_suffix"
            make_launch "retroarch -L $retroarch_cores/$core $2$rom_suffix"
            #make_launch "retroarch_mme4crt -L $retroarch_cores/$core $2$rom_suffix"
        else
            #make_launch "retroarch_176 --verbose -L $retroarch_cores/$core $2$rom_suffix >> $work_dir/retroarch.log 2>&1"
            make_launch "retroarch --verbose -L $retroarch_cores/$core $2$rom_suffix 2> $work_dir/retroarch.log"
            #make_launch "retroarch_mme4crt --verbose -L $retroarch_cores/$core $2$rom_suffix >> $work_dir/retroarch.log 2>&1"
            #make_launch "retroarch_mme4crt --verbose -L $retroarch_cores/$core $2$rom_suffix >> /root/retroarch.log"
        fi
        launch_selection
    else
        log_msg "launch_retroarch_core : $1 core does not exist in database/emulators.cfg. Please add it" 0
    fi

}


# copies another Button layout for up to 4 buttons games 
# only for FB Alpha and uses overrides

function change_button_layout () {
    log_msg "change_button_layout : set button layout $BUTTONLAYOUT" 0
    if [ "$BUTTONLAYOUT" == "3" ]; then
        cp $retroarch_folder/retroarch_3B.cfg $retroarch_folder/config/FB\ Alpha/FB\ Alpha.cfg
        #REMAP_FBA="N"
        mv $retroarch_folder/config/remaps $retroarch_folder/config/remaps_ > /dev/null 2>&1
    elif [ "$BUTTONLAYOUT" == "4" ]; then
        cp $retroarch_folder/retroarch_4B.cfg $retroarch_folder/config/FB\ Alpha/FB\ Alpha.cfg
        #REMAP_FBA = "Y"
    else 
        cp $retroarch_folder/retroarch_6B.cfg $retroarch_folder/config/FB\ Alpha/FB\ Alpha.cfg
        #REMAP_FBA = "Y"
    fi
    #set_remap
}

function handleUsbGamepad () {
    # todo 
    # check if connected, 
    # if not set to nousb
    log_msg "handleUsbGamepad : handle usb gamepad $USB_GAMEPAD" 0
    change_ra_param_set "$ctrl_path/$USB_GAMEPAD"
    rm tmp/gamepad/* > /dev/null 2>&1
    touch tmp/gamepad/$USB_GAMEPAD
    cat .lemonlauncher/lemonlauncher_template.conf .lemonlauncher/lemonlauncher_$USB_GAMEPAD.cfg > .lemonlauncher/lemonlauncher.conf        

    # automatic settings for remaps?
	#if [ "$USB_GAMEPAD" = "nousb" ] ; then
    #    REMAP_FBA = "Y"
    #fi

    ## todo since the retroarch autoconfig exists this could be reused here.
}


function main ()
{
    log_msg "main : Welcome to the main function of Regamebox!" 0
    before_total=$(date +%s.%N)
 
	check_running

	cd /root

	mount_usb_stick        
	set_work_dir

    before=$(date +%s.%N)
    # contains autoconfig of pi2jamma driver
	read_config_files
	timer "main : read_config_files" "$before"
    # we have to wait for the initialization of pi2jamma controls
    # then we can interact with the user.

    # if usb stick has no valid folder rpi2jamma
    # ask user to generate folders
    generate_USB_folder_startup


    mount /dev/mmcblk0p3 /mnt/ntfs > /dev/null 2>&1
        
	#switch off console blanking
	#setterm -blank 0

	patch_handling

	# cleanup for temporay file
	#rm_xist -r /tmp/*


	#if [ "$INIT_REGAMEBOX" = "Y" ]; then
    #    init_regamebox
    #fi

    before=$(date +%s.%N)
    handle_resmode
    timer "res_mode" "$before"


    before=$(date +%s.%N)        
    handle_orientation
    timer "handle_orientation" "$before"

    before=$(date +%s.%N)        
    change_button_layout
    timer "change_button_layout" "$before"

    before=$(date +%s.%N)
    set_remap
    timer "set_remap" "$before"

    before=$(date +%s.%N)        
	check_autostart
    timer "check_autostart" "$before"


    before=$(date +%s.%N)
    if [ "$REFRESH_GAMELIST" == "Y" ]; then
        gamelister
    fi
    timer "gamelister" "$before"


    before=$(date +%s.%N)        
    set_res_lemonlauncher
    timer "set_res_lemonlauncher" "$before"


    before=$(date +%s.%N)        
    handle_wlan
    timer "handleWLAN" "$before"


    before=$(date +%s.%N)        
    handleUsbGamepad
    timer "handleUsbGamepad" "$before"


    timer "total start" "$before_total"


}

main

log_msg "loop : starting the loop!" 0

while [ 1 ]
do
    clear_screen
    setterm -cursor off
    log_msg "loop : set_res_lemonlauncher" 0
    
    set_res_lemonlauncher
    cd /root

    if [ "$auto_turn_screen" == "Y" ]; then
        python3 /root/scripts/gpio_26_off.py
        log_msg "loop : turn screen horizontal, gpio 26 off" 0
    fi
        

    # watch out the config file in /etc/pikeyd165.conf
    # turn on pikeyd for ll menu
    pikeyd165_start
    
    # background music
    #--loop < 0
    kill_running mpg123
    
    #n247 check if we have a playlist before trying to play it
    if [ "$AUDIOMODE" == "Y" ]; then
        if [ -f $work_dir/menu-audio/$menu_audio ]; then
	        log_msg "Starting Background Music" 0
            if [ -f config/volume.conf ]; then
    	        volume=$(cat config/volume.conf)
                # menu volume should be lower
                #volume_menu=$((volume-15))
                volume_menu=$((volume-5))
                log_msg "Volume is $volume_menu %"
	        	amixer sset PCM,0 $volume_menu% &> /dev/null
	        else
		        amixer sset PCM,0 65% &> /dev/null
            fi
            mpg123 -q -@ $work_dir/menu-audio/$menu_audio &
	    fi
    fi
    #http://derpi.tuwien.ac.at/cgi-bin/man/man2html?1+mpg123

    # start lemmonlauncher and report back the selected item
    log_msg "loop : start lemonlauncher" 0

    lemonlauncher |grep "Lemonresult:" > tmp/llresult.txt 2>&1 
    clear_screen
    
    result=`cat tmp/llresult.txt |awk '{print $4 " " $3}'`

    log_msg "loop : lemonlauncher gives $result" 0
    
    #lastitem=`cat tmp/llresult.txt |awk '{print $NF}'`
    
    #debug_launcher_result

    # ok, decide what to do
    if [ -n "$result" ]; then
    
        kill_running mpg123
        #amixer sset PCM,0 $volume% &> /dev/null
        if [ -f config/volume.conf ]; then
            volume=$(cat config/volume.conf)
            log_msg "Game Volume is $volume %"
	        amixer sset PCM,0 $volume% &> /dev/null
	    else
            amixer sset PCM,0 100% &> /dev/null
        fi
        
        #for games.conf for  m4all, pifbam advmenu,
        #generated by this script (arcade version)
        emu=`echo $result|awk '{print $1}'`
	    rom=`echo $result|awk '{print $2}'`

        #for gamelister games
        #clean leading stuff
        game=`cat tmp/llresult.txt |awk -F ";" '{print $2}'| cut -c 3-`
        
        #delete trailing space
        game=`echo ${game%?}` 
        
	    #emulator for console version
        console=`cat tmp/llresult.txt |awk -F ";" '{print $3}'`
		
    	# add game to history list
	    if [ "$HISTORYMODE" == "Y" ]; then
            
            more .lemonlauncher/games.conf | grep "params = \";$console\"" | grep "rom = \"$game\"" > tmp/history_tmp

            history_add=$(cat tmp/history_tmp)
            EMPTY=`more tmp/history_tmp |wc -l`
            if [ "$EMPTY" -ge "1" ]; then
	        # last in first out
                log_msg "loop : added $game to history" 0

                sed -i "3i $history_add" $work_dir/history.conf &> /dev/null
                
                hide_history
                show_history                
            fi
        fi


        if [ "$emu" == "delallfav" ]; then
            log_msg "Delete all favs" 0
            rm_xist $work_dir/favourites.conf
            cp tmp/fav_template $work_dir/favourites.conf
            cp .lemonlauncher/games.conf_tmp .lemonlauncher/games.conf
            makeGamesConf

        fi

        if [ "$emu" == "delfav" ]; then

            more $work_dir/favourites.conf | grep "params = \";$last_emu\"" | grep "rom = \"$last_game\"" > tmp/fav_tmp
            fav_del=$(cat tmp/fav_tmp)

            sed -i "/$fav_del*/d" $work_dir/favourites.conf &> /dev/null

            hide_fav
            show_fav
            cp .lemonlauncher/games.conf_tmp .lemonlauncher/games.conf
            makeGamesConf

        fi

        if [ "$emu" == "delfav_short" ]; then
            more $work_dir/favourites.conf | grep "params = \";$last_emu\"" | grep "rom = \"$last_game\"" > tmp/fav_tmp
            fav_del=$(cat tmp/fav_tmp)

            sed -i "/$fav_del*/d" $work_dir/favourites.conf &> /dev/null

            makeGamesConf
        fi


        if [ "$emu" == "addfav" ]; then
            
            rm_xist tmp/fav_tmp
            cat .lemonlauncher/arcade_games.conf .lemonlauncher/console_games.conf > tmp/all_games.conf
            more tmp/all_games.conf | grep "params = \";$last_emu\"" | grep "rom = \"$last_game\"" >> tmp/fav_tmp
             
            fav_add=$(cat tmp/fav_tmp)
            EMPTY=`more tmp/fav_tmp |wc -l`
            if [ "$EMPTY" -ge "1" ]; then
    	        # last in first out
                log_msg "added $game to fav" 0

                sed -i "5i $fav_add" $work_dir/favourites.conf > /dev/null
                
                hide_fav
                show_fav                
                cp .lemonlauncher/games.conf_tmp .lemonlauncher/games.conf
                makeGamesConf
            fi
	    fi

        if [ "$emu" == "addfav_short" ]; then
            rm_xist tmp/fav_tmp
            cat .lemonlauncher/arcade_games.conf .lemonlauncher/console_games.conf > tmp/all_games.conf
            more tmp/all_games.conf | grep "params = \";$last_emu\"" | grep "rom = \"$last_game\"" >> tmp/fav_tmp
            fav_add=$(cat tmp/fav_tmp)
            EMPTY=`more tmp/fav_tmp |wc -l`
            if [ "$EMPTY" -ge "1" ]; then
	            # last in first out
                log_msg "added $last_game to fav" 0

                sed -i "5i $fav_add" $work_dir/favourites.conf &> /dev/null
                
                makeGamesConf
            fi
    	fi

        ####### LAUNCHER #######
        if  [ ! -z "$console" ] && [ ! -z "$game" ]; then
            log_msg "loop : Launching $console $game" 0
            make_launch init
            LAUNCHFILE="\""$console_roms"/"$console"/"$game"\""
            log_msg "loop : call launch_retroarch_core $console" 0 
            launch_retroarch_core "$console" "$LAUNCHFILE"
            cp tmp/llresult.txt tmp/llresult.tmp

        fi

        
        if [ "$console" == "pifba" ]; then
            #cd $PIFBAHOME

            if [ "$CUSTOMRESMODE" = "Y" ]; then
                log_msg "loop : check function set_videotiming" 1
                log_msg "loop : todo : execute compute res" 0
            fi
            #pikeyd165_stop
            LAUNCHFILE=""$console_roms"/"$console"/"$game".zip"

            $PIFBAHOME/fba2x_1st $LAUNCHFILE
            #/usr/local/share/piFBA/fba2x_1st /mnt/sda/rpi2jamma/roms/pifba/$game.zip
            #/usr/local/share/piFBA/fba2x_1st $LAUNCHFILE
            log_msg "loop : Launched piFBA $LAUNCHFILE" 0

        fi

        if [ "$console" == "c64" ]; then
            launch_resolution "x64" 
            cd /root
            log_msg "loop : Starting C64 Emu" 0
            
            ## C64 Key Mapping
            
            pikeyd165_stop
            cp /etc/pikeyd165.conf /etc/pikeyd165_backup.conf
            cp /etc/pikeyd165_c64.conf /etc/pikeyd165.conf
            pikeyd165_start
            make_launch "x64 -config /root/.vice/dtv-settings $LAUNCHFILE > /dev/null 2>&1"
            
            make_launch "x64 $LAUNCHFILE"
            launch_selection
            
            ## Normal Key Mapping
            pikeyd165_stop
            cp /etc/pikeyd165_backup.conf /etc/pikeyd165.conf
            
        fi
        
        if [ "$console" == "c64dtv" ]; then
            launch_resolution $console 
            cd /root
            log_msg "loop : Starting C64 DTV Emu" 0
            pikeyd165_stop
            cp /etc/pikeyd165.conf /etc/pikeyd165_backup.conf
            cp /etc/pikeyd165_c64.conf /etc/pikeyd165.conf
            pikeyd165_start
            #sleep 10
            #make_launch "x64dtv -config /root/.vice/c64dtv.cfg -c64dtvromimage $LAUNCHFILE"
            make_launch "x64dtv -config /root/.vice/dtv-settings -c64dtvromimage $LAUNCHFILE > /dev/null 2>&1"
            launch_selection
            
            ## Normal Key Mapping
            pikeyd165_stop
            cp /etc/pikeyd165_backup.conf /etc/pikeyd165.conf
        fi
        
        if [ "$console" == "advmame" ]; then
            #make_launch "/root/local/bin/advmame38 -cfg $ADVHOME/advmame.rc "$game"
            make_launch "/root/local/bin/advmame38 $game"
            
            launch_selection
            cp tmp/llresult.txt tmp/llresult.tmp

        fi

        #for mp3 or pls files
        if [ "$console" == "jukebox" ]; then
            cd /root
            echo "jukebox: " 
            pikeyd165_stop
            cp /etc/pikeyd165.conf /etc/pikeyd165_backup.conf
            cp /etc/pikeyd165_jukebox.conf /etc/pikeyd165.conf
            pikeyd165_start
            make_launch "mpg123 -C -@ $LAUNCHFILE"
            launch_selection
            #quit mpg123?
            pikeyd165_stop
            cp /etc/pikeyd165_backup.conf /etc/pikeyd165.conf
        fi
        
        if [ "$emu" == "retroarch_config" ]; then
            launch_resolution default
            retroarch --menu 
        fi

        if [ "$emu" == "c64_config" ]; then
            set_res_default
            cd /root
            log_msg "loop : Starting C64 Emu" 0    
            
            # TODO whiptail
            whiptail --infobox "Press Start Player 1 for Config Menu (F12)" 25 40
            sleep 3
            clear_screen
            ## C64 Key Mapping
            
            pikeyd165_stop
            cp /etc/pikeyd165.conf /etc/pikeyd165_backup.conf
            cp /etc/pikeyd165_c64.conf /etc/pikeyd165.conf
            pikeyd165_start
            
            x64
            
            ## Normal Key Mapping
            pikeyd165_stop
            cp /etc/pikeyd165_backup.conf /etc/pikeyd165.conf
            
        fi
        
        if [ "$emu" == "shell" ]; then
            set_res_default 
            echo "Shell"
            log_msg "loop : Launched cmd shell" 0
            # stop keys with control panel
            # perhaps do not stop, because of emu test
            # pikeyd165_stop
            
            # needed for test
            clear_screen
            setterm -cursor on

            exit 0
        fi

        if [ "$emu" == "wifi" ]; then
            log_msg "loop : config wifi" 0
            set_res_default
            setterm -cursor on
            wifi-menu -o
            whiptail --infobox "WIFI will now be enabled. Waiting 20 sec for connection." 10 40 
            sleep 20
            handle_wlan "netctl_enable"
            clear_screen
        fi

        if [ "$emu" == "wifi_disable" ]; then
            whiptail_msgbox "Wifi Disable" "WIFI will now be disabled." 10 40 
            log_msg "loop : disable wifi" 0
            handle_wlan "wifi_disable"
            
        fi


        if [ "$emu" == "set_overscan" ]; then
            cd /root/scripts
            sh set_overscan.sh
            cd /root
        fi
        
        if [ "$emu" == "ip_address" ]; then
            set_res_default
            ip_add=`hostname -i`
            whiptail_msgbox "IP Address" "IP address is $ip_add." 10 40 
            log_msg "loop : show ip address $ip_add" 0
            # TODO does not work always
        fi

        if [ "$emu" == "usbstick_import" ]; then
            if [ "$USBSTICK" == "Y" ]; then
                space=`df / | grep root | cut -d" " -f13`
                used=`du -s /mnt/sda/rpi2jamma/roms | cut -d"/" -f2`

                if [ $space > $used ]; then 

                    log_msg "loop : copy roms from USB Stick to SD CARD." 0
                    text="You want to copy roms from USB Stick to SD CARD."
                    text="$text\nPlease wait!"
                    whiptail --infobox "$text" 25 40
                    cp -r $USB_PATH/roms $SD_PATH
                    text="$text\n\nDone .... Thanks for waiting."                
                    whiptail --infobox "$text" 25 40
                else
                    whiptail --infobox "Not enough space, sorry." 25 40
                    sleep 3
                fi
                clear_screen
            fi
        fi

        if [ "$emu" == "usbstick_init" ]; then
            
            if [ "$USBSTICK_INIT" == "valid" ]; then
                log_msg "loop : Generate USB Stick folders." 0
                text="Valid empty USB Stick found."
                text="$text\nUSB Stick will be initialized" 
                text="$text with the folder structure."
                text="$text\nPlease wait!"
                whiptail --infobox "$text" 25 40
                sh /root/scripts/init_usbstick.sh $BASE_FOLDER
                text="$text\n\nDone .... Thanks for waiting."
                
                whiptail --infobox "$text" 25 40
                sleep 3
                clear_screen

            fi
        fi 

        if [ "$emu" == "show_cores" ]; then
            clear_screen
            set_res_default
            echo "Show installed Retroarch Cores."
            echo "Retroarch cores are installed in /root/.config/retroarch/cores"
            ls /root/.config/retroarch/cores | grep "libretro.so" 
            log_msg "loop : show cores" 0
            echo "return to menu in 10 secs"

            sleep 10
        fi


        if [ "$emu" == "reboot" ]; then
            set_res_default
            log_msg "loop : Reboot" 0
            shutdown -r now
            exit 0
        fi
        
        if [ "$emu" == "shutdown" ]; then
            set_res_default
            log_msg "loop : Shutdown" 0
            shutdown -h now
            exit 0
        fi

        if [ "$emu" == "edit_emulators" ]; then
            set_res_default
            setterm -cursor on

            cp  $database/emulators.conf $database/emulators.conf_backup
            nano $database/emulators.conf
            log_msg "loop : Edit Emulator Config" 0
        fi

        if [ "$emu" == "edit_regambox_config" ]; then
            set_res_default
            setterm -cursor on
            #if [ "$resmode" == "low" ]; then
            cp  "$config_file" "$config_file""_backup"
            nano "$config_file"
            log_msg "loop : Edit Regamebox Config" 0
        fi


        if [ "$emu" == "edit_arcade_resolution" ]; then
            set_res_default
            setterm -cursor on
            #if [ "$resmode" == "low" ]; then
            cp  $database/arcade_res_table.txt $database/arcade_res_table.txt_backup
            nano $database/arcade_res_table.txt
            log_msg "loop : Edit /root/database/arcade_res_table.txt" 0
        fi
        
        if [ "$emu" == "edit_retroarch" ]; then
            set_res_default
            setterm -cursor on

            #if [ "$resmode" == "low" ]; then
            cp  "$retroarch_conf" "$retroarch_conf""_backup"
            nano "$retroarch_conf"
            log_msg "loop : Edit retroarch Config" 0
        fi
        
        if [ "$emu" == "edit_advmame" ]; then
            set_res_default
            setterm -cursor on
 
            if [ "$RESMODE" == "LOW" ]; then
            
                cp  $ADVHOME/advmame_lowres.rc $ADVHOME/advmame_lowres.rc_backup
                nano $ADVHOME/advmame_lowres.rc
                cp  $ADVHOME/advmame_lowres.rc $ADVHOME/advmame.rc
            elif [ "$RESMODE" == "HIGH" ]; then
                cp  $ADVHOME/advmame_highres.rc $ADVHOME/advmame_highres.rc_backup
                nano $ADVHOME/advmame_highres.rc
                cp  $ADVHOME/advmame_highres.rc $ADVHOME/advmame.rc
            fi 

            log_msg "Edit advmame Config" 0
        fi
        
        if [ "$emu" == "edit_games_config" ]; then
            set_res_default
            cp /root/.lemonlauncher/games.conf /root/.lemonlauncher/games.conf_backup
            nano /root/.lemonlauncher/games.conf
            log_msg "loop : Edit Games Config" 0
        fi

        if [ "$emu" == "editpls" ]; then
            set_res_default
            setterm -cursor on

            cp $work_dir/menu-audio/arcade.pls $work_dir/menu-audio/arcade.pls_backup 
            nano $work_dir/menu-audio/arcade.pls 
            log_msg "loop : Edit Playlist" 0
        fi

        
        if [ "$emu" == "edit_key_config" ]; then
            set_res_default
            setterm -cursor on

            cp /etc/pikeyd165.conf /etc/pikeyd165.conf_backup
            nano /etc/pikeyd165.conf
            log_msg "loop : Edit keys Pikyed Config" 0
        fi

        if [ "$emu" == "edit_c64_key_config" ]; then
            set_res_default
            setterm -cursor on

            cp /etc/pikeyd165_c64.conf /etc/pikeyd165_c64.conf_backup
            nano /etc/pikeyd165_c64.conf
            log_msg "loop : Edit C64 Keys Pikyed Config" 0
        fi

        if [ "$emu" == "edit_custom_res" ]; then
            set_res_default
            #setterm -cursor on
            cp $database/custom_resolutions.txt $database/custom_resolutions.txt_backup

            if [ "$RESMODE" == "HIGH" ]; then            
                log_msg "loop : no custom resolution needed in high mode"
                #sleep 2
            elif [ "$RESMODE" == "LOW" ]; then            
                nano $database/custom_resolutions.txt
            fi 

            log_msg "loop : Edit Custom Resolution" 0
        fi
        
        if [ "$emu" == "backup" ]; then
            set_res_default
            echo "An Image will now generated on the connected USB Stick"
            echo "Please wait"
            sleep 2
            umount /boot
            cd /mnt/sda
            sh /root/scripts/do_export.sh
            echo "Image was made"
            log_msg "loop : backup generating Image" 0
            sleep 2
            shutdown -r now
        fi
        
        if [ "$emu" == "showlastgame" ]; then

            text="$text\n Last game played was : $last_game"
            text="$text\n Emulator used was : $last_emu"
            whiptail_msgbox "Show Game" "$text" 10 30
            log_msg "loop : showlastgame $last_game with $last_emu" 0
        fi

        if [ "$emu" == "AdvMenu" ]; then
            /root/scripts/adv_start.sh
            log_msg "loop : Starting AdvMenu" 0
        fi
        
        if [ "$emu" == "export_config" ]; then
            set_res_default
            mkdir /mnt/sda/config
            cp -r /root/.config/retroarch /mnt/sda/config
            cp $ADVHOME/advmame.rc /mnt/sda/config
            cp $ADVHOME/advmenu.rc /mnt/sda/config
            cp -r /root/.vice /mnt/sda/config
            cp /etc/pikeyd165.conf /mnt/sda/config
            cp /root/.lemonlauncher/lemonlauncher.conf /mnt/sda/config
            cp /root/log.txt /mnt/sda/config
            cd /mnt/sda 
            tar czf config_pi2jamma_$(date +%Y%m%d).tgz config
            cd /root
            log_msg "loop : Export config" 0
        fi

        if [ "$emu" == "import_config" ]; then
            set_res_default
            mkdir /mnt/sda/backup_config
            cp -r /root/.config/retroarch /mnt/sda/backup_config
            cp $ADVHOME/advmame.rc /mnt/sda/backup_config
            cp $ADVHOME/advmenu.rc /mnt/sda/backup_config
            cp -r /root/.vice /mnt/sda/backup_config
            cp /etc/pikeyd165.conf /mnt/sda/backup_config
            cp /root/.lemonlauncher/lemonlauncher.conf /mnt/sda/backup_config
            cp /root/log.txt /mnt/sda/backup_config
            
            tar xcf /mnt/sda/config_pi2jamma.tgz 
            
            # copy needed files
            cp -r /mnt/sda/config/retroarch /root/.config
            cp /mnt/sda/config/advmame.rc $ADVHOME
            cp /mnt/sda/config/advmenu.rc $ADVHOME/
            cp -r /mnt/sda/config/.vice /root
            cp -r /mnt/sda/config/.mednafen /root
            cp /mnt/sda/config/pikeyd165.conf /etc
            cp /mnt/sda/config/lemonlauncher.conf /root/.lemonlauncher
            log_msg "loop : Import config" 0
        fi

        if [ "$emu" == "themes" ]; then
            
            set_res_default
            cp /root/themes/"$emu"/"$rom"/* /root/.lemonlauncher
            # we need a base a config to add USB controller on the fly
            cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf
            handleUsbGamepad
            handle_orientation
            log_msg "loop : Launching lowres Theme $rom" 0
        fi    
        if [ "$emu" == "themes_highres" ]; then
            
            set_res_default
            cp /root/themes/"$emu"/"$rom"/* /root/.lemonlauncher
            # we need a base a config to add USB controller on the fly
            cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf
            handleUsbGamepad
            handle_orientation

            log_msg "loop : Launching highres Theme $rom" 0
        fi    


        if [ "$emu" == "buttonlayout" ]; then
            if [ "$BUTTONLAYOUT" == "3" ]; then
                BUTTONLAYOUT="4"
                set_mode "Switch to 4 Buttons" "Switch to 6 Buttons" "BUTTONLAYOUT" "3" "4"
                log_msg "loop : 4 Buttons Layout" 0
            elif [ "$BUTTONLAYOUT" == "4" ]; then
                BUTTONLAYOUT="6"
                set_mode "Switch to 6 Buttons" "Switch to 3 Buttons" "BUTTONLAYOUT" "4" "6"
                log_msg "loop : 6 Buttons Layout" 0
            else
                BUTTONLAYOUT="3" 
                set_mode "loop : Switch to 3 Buttons" "Switch to 4 Buttons" "BUTTONLAYOUT" "6" "3"
                log_msg "3 Buttons Layout" 0
            fi
            change_button_layout
        fi         


        if [ "$emu" == "toggleparents" ]; then
	    if [ "$SHOW_PARENTS" == "Y" ]; then
                SHOW_PARENTS="N"
                log_msg "loop : Show full list" 0
                set_mode "Show Full List" "Show Only Parents" "SHOW_PARENTS" "Y" "N"
            else         
                SHOW_PARENTS="Y"
                log_msg "loop : Show parents list" 0
                set_mode "Show Only Parents" "Show Full List" "SHOW_PARENTS" "N" "Y"
            fi
            gamelister
        
        fi       

        
        if [ "$emu" == "confmode" ]; then
	    if [ "$CONFMODE" == "1" ]; then
                CONFMODE="0"
                log_msg "loop : Set confmode to simple" 0
                set_mode "Switch To Simple Config" "Switch To Extended Config" "CONFMODE" "1" "0"
	    else
                CONFMODE="1"
                log_msg "loop : Set confmode to extended" 0
                set_mode "Switch To Extended Config" "Switch To Simple Config" "CONFMODE" "0" "1"
            fi
            makeGamesConf
        fi

        # multiple layers of games.conf
        if [ "$emu" == "options_conf" ]; then
            cp .lemonlauncher/games.conf .lemonlauncher/games.conf_tmp
            cp frontend/options.conf .lemonlauncher/games.conf
        fi

        if [ "$emu" == "themes_conf" ]; then
            cp .lemonlauncher/games.conf .lemonlauncher/games.conf_tmp
            cp frontend/themes.conf .lemonlauncher/games.conf
        fi

        if [ "$emu" == "gamelists_conf" ]; then
            cp .lemonlauncher/games.conf .lemonlauncher/games.conf_tmp
            cp frontend/gamelists.conf .lemonlauncher/games.conf
        fi

        if [ "$emu" == "exitconf" ]; then
            cp .lemonlauncher/games.conf_tmp .lemonlauncher/games.conf
        fi


        if [ "$emu" == "toggleautostart" ]; then
            if [ "$AUTOSTART" == "1" ]; then
                AUTOSTART="0"
                rm /root/tmp/lastgame.txt
                set_mode "Turn Autostart Off" "Turn Autostart On" "AUTOSTART" "1" "0"

                log_msg "loop : Autostart off for \" $last_game \"" 0

	    else
                AUTOSTART="1"                
                cp /root/tmp/llresult.tmp /root/tmp/lastgame.txt

                set_mode "Turn Autostart On" "Turn Autostart Off" "AUTOSTART" "0" "1"

                log_msg "loop : Autostart on for \" $last_game \"" 0
                echo "Autostart on for \" $last_game \""
                sleep 2
            fi
        fi


        if [ "$emu" == "ToggleCustomRes" ]; then
            log_msg "loop : Toggle CustomRes" 0
            if [ "$CUSTOMRESMODE" == "Y" ]; then
                CUSTOMRESMODE="N"
                log_msg "loop : Custom Resolutions off" 0
                set_mode "Turn Custom Res Off" "Turn Custom Res On" "CUSTOMRESMODE" "Y" "N"
            else 
                CUSTOMRESMODE="Y"
                log_msg "loop : Custom Resolutions on" 0
                set_mode "Turn Custom Res On" "Turn Custom Res Off" "CUSTOMRESMODE" "N" "Y"

            fi
        fi


        if [ "$emu" == "ToggleFav" ]; then
            if [ "$FAVOURITESMODE" == "Y" ]; then
                FAVOURITESMODE="N"
                log_msg "loop : FAVOURITES off" 0
                hide_fav
                set_mode "Turn Favourites Menu Off" "Turn Favourites Menu On" "FAVOURITESMODE" "Y" "N"
            else 
                FAVOURITESMODE="Y"
                log_msg "loop : FAVOURITES on" 0
                show_fav 
                set_mode "Turn Favourites Menu On" "Turn Favourites Menu Off" "FAVOURITESMODE" "N" "Y"                
            fi
        fi

        if [ "$emu" == "ToggleHistory" ]; then
            if [ "$HISTORYMODE" == "Y" ]; then
                HISTORYMODE="N"
                log_msg "loop : HISTORY off" 0
                hide_history
                set_mode "Turn History Menu Off" "Turn History Menu On" "HISTORYMODE" "Y" "N"
            else 
                HISTORYMODE="Y"
                log_msg "loop : HISTORY on" 0
                # add new history.conf
                if [ -f "$work_dir/history.conf" ]; then
                    log_msg "loop : history.conf found" 0
                else
                    log_msg "loop : copy new history.conf from templates/history_template" 0
                    cp templates/history_template $work_dir/history.conf
                fi
                cat .lemonlauncher/games.conf_tmp $work_dir/history.conf > tmp/games.conf_tmp
                cp tmp/games.conf_tmp .lemonlauncher/games.conf_tmp
                set_mode "Turn History Menu On" "Turn History Menu Off" "HISTORYMODE" "N" "Y"
            fi
        fi

        if [ "$emu" == "DeleteHistory" ]; then
            log_msg "Delete History" 0
            # delete last history in games.conf
            # assumes that history is last menu item! 
            hide_history
            rm_xist $work_dir/history.conf
            cp templates/history_template $work_dir/history.conf
        fi



        if [ "$emu" == "ToggleHV" ]; then
        
            log_msg "loop : Toggle HV" 0
            if [ "$ORIENTATION" == "H" ]; then
                ORIENTATION="V"
                set_mode "Switch to Vertical Screen" "Switch to Horizontal Screen" "ORIENTATION" "H" "V"
                
                # copy default V theme
                cp /root/themes/themes/simple-vert/* /root/.lemonlauncher
                cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf 


            else
                ORIENTATION="H"
                #cp /root/.lemonlauncher/lemonlauncherV.conf /root/.lemonlauncher/lemonlauncher.conf 
                set_mode "Switch to Horizontal Screen" "Switch to Vertical Screen" "ORIENTATION" "V" "H"
                
                #copy default themes
                if [ "$RESMODE" == "LOW" ]; then
                    cp /root/themes/themes/simple/* /root/.lemonlauncher
                else
	                cp /root/themes/themes_highres/turrican/* /root/.lemonlauncher
                fi
                cp /root/.lemonlauncher/lemonlauncher.conf /root/.lemonlauncher/lemonlauncher_template.conf 

            fi

            # exit to game menu
    	    cp .lemonlauncher/games.conf_tmp .lemonlauncher/games.conf

            handle_orientation
            makeGamesConf

        fi
        
        if [ "$emu" == "ToggleMusic" ]; then
            if [ "$AUDIOMODE" == "Y" ]; then
                AUDIOMODE="N"
                log_msg "loop : Music off" 0
                set_mode "Turn Music Off" "Turn Music On" "AUDIOMODE" "Y" "N"
            else 
                AUDIOMODE="Y"
                log_msg "Ãloop : Music on" 0
                set_mode "Turn Music On" "Turn Music Off" "AUDIOMODE" "N" "Y"
            fi
        fi

        
        if [ "$emu" == "lock" ]; then
            log_msg "loop : Lock Games" 0
            pikeyd165_stop
            cp /etc/pikeyd165_lock.conf /etc/pikeyd165.conf
        fi

        if [ "$emu" == "unlock" ]; then
            log_msg "loop : Unlock Games" 0
            pikeyd165_stop
            cp /etc/pikeyd165_unlock.conf /etc/pikeyd165.conf      
        fi

        if [ "$emu" == "usb_gamepad_wizard" ]; then
            set_res_default
            log_msg "loop : USB Gamepad wizard" 0
            usb_gamepad_wizard
        fi


        if [ "$emu" == "usb_gamepad" ]; then
            set_res_default
            log_msg "loop : Select USB Gamepad" 0
            select_usb_gamepad
        fi
        
        if [ "$emu" == "crt_profile" ]; then
            set_res_default
            log_msg "loop : Select CRT Profile" 0
            select_crt_profile
        fi
        
        if [ "$emu" == "center_image" ]; then
            set_res_default
            log_msg "loop : calibration screen" 0
            whiptail --title "Calibrate Screen" --msgbox "After calibrating custom crt profile is set." 20 40
            cd /root/resolution    
            #sh start_crt_config.sh
            python3 calibrate_screen.py 1920 228 60 2 > /dev/null 2>&1
            # needed
            sh ./post_res_.sh

            #whiptail_yesno "Calibration Screen Confirmation" "Shall the new calibration used as custom base settings?" 20 40 
            #if [ "$whiptail_return" == "yes" ]; then
            #    cp /root/resolution/calibration.conf /root/config/screens/calibration_base.conf
            #    log_msg "new calibraton base set with calibration tool." 0
            #fi

            cd /root    
            clear_screen
        fi

        if [ "$emu" == "SetVolume" ]; then
            set_res_default
            log_msg "loop : Set Volume" 0
            sh scripts/set_volume.sh
        fi

        
        if [ "$emu" == "pi2scart" ]; then
            log_msg "loop : Toggle pi2scart_mode" 0
            if [ "$PI2SCART" == "Y" ]; then                
                PI2SCART="N"
                log_msg "loop : PI2SCART off" 0
                set_mode "Switch to Pi2JAMMA" "Switch to Pi2SCART" "PI2SCART" "Y" "N"
            else 
                PI2SCART="Y"
                log_msg "loop : PI2SCART on" 0
                set_mode "Switch to Pi2SCART" "Switch to Pi2JAMMA" "PI2SCART" "N" "Y"
            fi
        fi

        # Toggle Left right if screen is vertical
        if [ "$emu" == "flip_v" ]; then
            log_msg "loop: Toggle vertical left right" 0
            if [ "$ORIENTATION_V" == "left" ]; then
                ORIENTATION_V="right"
                log_msg "loop : Orientation_V right" 0
                set_mode "Flip Screen" "Flip Screen" "ORIENTATION_V" "left" "right"
            else 
                ORIENTATION_V="left"
                log_msg "loop : Orientation_V left" Ã0
                set_mode "Flip Screen" "Flip Screen" "ORIENTATION_V" "right" "left"
            fi
            handle_orientation
        fi

        # Flip normal flip if screen is vertical
        if [ "$emu" == "flip_h" ]; then
            log_msg "loop : Flip horizontal normal flip" 0
            if [ "$ORIENTATION_H" == "normal" ]; then
                ORIENTATION_H="flip"
                log_msg "loop : Orientation_H flip" 0
                set_mode "Flip Screen" "Flip Screen" "ORIENTATION_H" "normal" "flip"
            else 
                ORIENTATION_H="normal"
                log_msg "loop : Orientation_H normal" 0
                set_mode "Flip Screen" "Flip Screen" "ORIENTATION_H" "flip" "normal"
            fi
            handle_orientation
        fi


        if [ "$emu" == "show_log" ]; then
            log_msg "loop : show_log" 0

            set_res_default
            cd /root
            pikeyd165_stop
            cp /etc/pikeyd165.conf /etc/pikeyd165_backup.conf
            cp /etc/pikeyd165_jukebox.conf /etc/pikeyd165.conf
            pikeyd165_start
            tail -n 100 log.txt |less
            pikeyd165_stop
            cp /etc/pikeyd165_backup.conf /etc/pikeyd165.conf
        fi

        if [ "$emu" == "show_mode" ]; then
            log_msg "loop : show_mode" 0

            set_res_default
            show_mode
        fi

        # Toggle low and highres for apps
        if [ "$emu" == "toggleres" ]; then
            log_msg "loop : Toggle RESMODE" 0
            if [ "$RESMODE" == "HIGH" ]; then
                RESMODE="LOW" 
                log_msg "loop : Lowres Mode activated" 0
                set_mode "Switch to Low Res" "Switch to High Res" "RESMODE" "HIGH" "LOW"
            else 
                RESMODE="HIGH" 
                log_msg "loop : Highres Mode activated" 0
                set_mode "Switch to High Res" "Switch to Low Res" "RESMODE" "LOW" "HIGH"
            fi
            handle_resmode
        fi


        # Toggle between german and english keyboard layout
        if [ "$emu" == "setkeyboardde" ]; then
            log_msg "loop: set german key layout" 0
            cp /etc/vconsole_de.conf /etc/vconsole.conf
            shutdown -r now
        fi

        # Toggle between german and english keyboard layout
        if [ "$emu" == "setkeyboardgb" ]; then
            log_msg "loop : set uk key layout" 0
            cp /etc/vconsole_gb.conf /etc/vconsole.conf
            shutdown -r now
        fi

        # Toggle between german and english keyboard layout
        if [ "$emu" == "setkeyboardus" ]; then
            log_msg "loop : set us key layout" 0
            cp /etc/vconsole_us.conf /etc/vconsole.conf
            shutdown -r now
        fi

        # Toggle between german and english keyboard layout
        if [ "$emu" == "setkeyboardfr" ]; then
            log_msg "loop : set fr key layout" 0
            cp /etc/vconsole_fr.conf /etc/vconsole.conf
            shutdown -r now
        fi



        if [ "$emu" == "showversion" ]; then
            log_msg "loop : showversion" 0
            whiptail --infobox "$VERSION\nby ArcadeForge.DE\ncheck doc page at pi2jamma.info" 20 40
            sleep 3
        fi
        
        if [ "$emu" == "refresh_gamelist" ]; then
            gamelister
            log_msg "loop : refresh gamelist" 0
        fi


        # test keys
        if [ "$emu" == "testkeys" ]; then
            set_res_default
            log_msg "loop : Test Keys" 0
            /root/local/bin/advk
        fi

        # test pad
        if [ "$emu" == "testpad" ]; then
            set_res_default
            log_msg "loop : Test Gamepad" 0
            /root/local/bin/advj
        fi

        if [ "$emu" == "check_pi2jamma" ]; then
            cd /root/work
            /root/scripts/check_pi2jamma.sh
            cd /root
            sleep 5
        fi
        if [ "$emu" == "default_ra_res" ]; then
            log_msg "loop: set retroarch resolution setting to default values" 0 
            set_ra_res

        fi

        # show help
        if [ "$emu" == "showhelp" ]; then
            #set_res_default
            log_msg "loop : Show Help" 0
           	text="******************************************"
    	    text="$text\n* Help Page *"
    	    text="$text\n******************************************"
            text="$text\n* Coin Player 1 is Start P1 + Player 1 Up*"
            text="$text\n* Coin Player 2 is Start P1 + Player 1 Up*"
            text="$text\n* Exit Game is Start P1 + Player B1      *"
            text="$text\n* Please refer to docs at pi2jamma.inof  *"
    	    text="$text\n******************************************"
        	whiptail_msgbox "Show Help" "$text" 25 50 

        fi

        cp /root/log.txt $work_dir > /dev/null
        
        set_res_default
        
        clear_screen

#    else

    	#sleep 0
        #setterm -cursor on
	    #shutdown -h 0
	    #exit 0
    fi

    sleep 0
    clear_screen    
done

fi
