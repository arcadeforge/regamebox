#!/usr/bin/env bash


crt_profile=consumer
tate_mode=no
overwrite_rom_cfg=yes



display_no_tate ()
{
    log "display no tate"
    # ok, we want to use a consumer crt with no tate.
    # so it  makes no sense for ie cave shooters to use 320 for heigth
    # just put them to 256 or other
    # all possible resolutions greater 256 follow
    if [ $rom_resolution_width == "768" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "720" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "640" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "543" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "512" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "479" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "448" ]; then
        rom_resolution_width="224"
    elif [ $rom_resolution_width == "400" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "384" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "376" ]; then
        rom_resolution_width="230"
    elif [ $rom_resolution_width == "360" ]; then
        rom_resolution_width="230"
    elif [ $rom_resolution_width == "352" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "338" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "336" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "320" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "305" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "304" ]; then
	rom_resolution_width="256"
    elif [ $rom_resolution_width == "304" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "304" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "294" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "288" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "288" ]; then
        rom_resolution_width="238"
    elif [ $rom_resolution_width == "276" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "272" ]; then
        rom_resolution_width="256"
    elif [ $rom_resolution_width == "260" ]; then
       rom_resolution_width="256"
    fi
			
    # Set custom_viewport_height
    # for vertical games on horizontal screen
    # height=width because rotate
    echo -e "custom_viewport_height = ""\"$rom_resolution_width\"" >> "$rom_fp"".cfg" 2>&1
    echo -e "custom_viewport_height = ""\"$rom_resolution_width\""
    rom_resolution_width=$rom_resolution_height

    # using constants when consumer crt
    echo -e "custom_viewport_width = \"1120\"" >> "$rom_fp"".cfg" 
    echo -e "custom_viewport_x = \"240\"" >> "$rom_fp"".cfg" 
				
    # new settings
    echo -e "video_scale_integer = false" >> "$rom_fp"".cfg" 
    echo -e "aspect_ratio_index = 22" >> "$rom_fp"".cfg" 
    echo -e "video_smooth = true" >> "$rom_fp"".cfg" 
    echo -e "video_threaded = false" >> "$rom_fp"".cfg" 
    echo -e "crop_overscan = false" >> "$rom_fp"".cfg" 

    vcgencmd hdmi_timings 1600 1 54 150 231 240 1 3 3 16 0 0 0 60 0 32000000 1
    tvservice -e "DMT 87"	
    fbset -depth 8 && fbset -depth 16 -xres 1600 -yres 240
    #exit 1
}
set_res () 
{

	#rm "$rom_fp"".cfg" 
  	log "$1"
	log "custom_viewport_width=$2"
	log "custom_viewport_x=$3"
	log "custom_viewport_height=$4"
	log "custom_viewport_y=$5"
	vcgencmd $1 > /dev/null

  	tvservice -e "DMT 87" > /dev/null
	fbset -depth 8 && fbset -depth 16 -xres $2 -yres $4 > /dev/null

	echo -e "custom_viewport_width = \"$2\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_x = \"$3\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_height = \"$4\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_y = \"$5\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "video_scale_integer = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "aspect_ratio_index = 22" >> "$rom_fp"".cfg" 2>&1
	echo -e "video_smooth = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "video_threaded = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "crop_overscan = false" >> "$rom_fp"".cfg" 2>&1
 
}

set_res_consoles ()
{
	#rm "$rom_fp"".cfg" 
  	log "hdmi_timings 2048 1 58 183 183 240 1 3 3 16 0 0 0 60 0 38893489 1 "
	log "custom_viewport_width=1855"
	log "custom_viewport_x=150"
	log "custom_viewport_height=224"
	log "custom_viewport_y=8"
	
	vcgencmd hdmi_timings 2048 1 58 183 183 240 1 3 3 16 0 0 0 60 0 38893489 1 > /dev/null 
	tvservice -e "DMT 87" > /dev/null
	fbset -depth 8 && fbset -depth 16 -xres 1920 -yres 240 > /dev/null

	echo -e "custom_viewport_width = \"1855\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_x = \"150\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_height = \"224\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "custom_viewport_y = \"8\"" >> "$rom_fp"".cfg"  2>&1
	echo -e "video_scale_integer = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "aspect_ratio_index = 22" >> "$rom_fp"".cfg" 2>&1
	echo -e "video_smooth = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "video_threaded = false" >> "$rom_fp"".cfg" 2>&1
	echo -e "crop_overscan = false" >> "$rom_fp"".cfg" 2>&1
}


function arcade_res(){
	log "Computing arcade resolution"

	# get the line number matching the rom
	rom_ln=$(tac /root/databases/resolution.ini | grep -w -n $rom_bn | cut -f1 -d":")

	# get resolution of rom
	rom_resolution=$(tac /opt/retropie/configs/all/resolution.ini | sed -n "$rom_ln,$ p" | grep -m 1 -F '[') 
	rom_resolution=${rom_resolution#"["}
	rom_resolution=${rom_resolution//]}
	rom_resolution=$(echo $rom_resolution | sed -e 's/\r//g')
	rom_resolution_width=$(echo $rom_resolution | cut -f1 -d"x")
	rom_resolution_height=$(echo $rom_resolution | cut -f2 -d"x")
        log "$rom_resolution_width"
        log "$rom_resolution_height"

	# Set rom_resolution_height for 480p and 448p roms
	if [ $rom_resolution_height == "480" ]; then
		rom_resolution_height="240"
	elif [ $rom_resolution_height == "448" ]; then
		rom_resolution_height="224"		
	fi	
	
	
	# determine if vertical  
	if grep -w "$rom_bn" /opt/retropie/configs/all/vertical.txt ; then 
		log "Game is vertical"
		# Add vertical parameters (video_allow_rotate = "true")
		if grep "video_allow_rotate" "$rom_fp"".cfg"; then
			log "video_allow_rotate exists in file."	
		else
			echo -e "video_allow_rotate = \"true\"" >> "$rom_fp"".cfg"
			log "video_allow_rotate = \"true\""
		fi
		
		# Add vertical parameters (video_rotation = 1)
		if grep "video_rotation" "$rom_fp"".cfg"; then
			log "video_rotation exists in file."
		else
			if [ "$tate_mode" = "yes" ] ; then
				echo -e "video_rotation = 1" >> "$rom_fp"".cfg"
				log "video_rotation set to tate mode."
			else
				echo -e "video_rotation = 0" >> "$rom_fp"".cfg" 
				log "video_rotation no tate mode."		
				display_no_tate
            fi # tate mode  
		fi # end video rotation handling
	fi # end vertical


#############################################################################################################
#
#
#   Handling of specific game resolution
#
#
#############################################################################################################
	
	# set arcade resolution based on system
	if [[ "$rom_bn" == "mpatrol" ]] ; then
		log "custom setting res for mpatrol"
		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 180 192 308 248 1 7 5 17 0 0 0 57 0 41051400 1" "1920" "0" "248" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1810" "70" "226" "7"
		fi
	elif [[ "$rom_bn" == "rtype" ]] || [[ "$rom_bn" == "rtype2" ]] ; then 
		log "custom setting res for rtype, rytpe2"
		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 180 192 308 256 1 8 5 18 0 0 0 55 0 41041000 1" "1920" "0" "256" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 256 1 5 5 16 0 0 0 56 0 37900800 1" "1830" "53" "226" "15"
		fi
	elif [[ "$rom_bn" == "mk" ]] ; then 
		log "custom setting res for mk"
		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 93 320 267 254 1 7 3 30 0 0 0 53.20 0 40670000 1" "1920" "0" "254" "0"
		else
			set_res "hdmi_timings 2048 1 58 183 183 265 1 8 3 8 0 0 0 55.35 0 38858356 1" "1885" "145" "226" "27"
		fi

#############################################################################################################
#
#
#   Handling of vertical games
#
#
#############################################################################################################		

		elif grep -w "$rom_bn" /opt/retropie/configs/all/vertical.txt ; then 
		if ! [ "$tate_mode" == "yes" ] ; then
			#vcgencmd hdmi_timings 1600 1 54 150 231 240 1 3 3 16 0 0 0 60 0 32000000 1
			set_res "hdmi_timings 1600 1 41 157 236 240 1 4 3 15 0 0 0 60 0 32000000 1" "1600" "0" "240" "0"
		else
			if [[ $rom_resolution_height == "224" ]] ; then
				# test with 1942 256 x 224
				set_res "hdmi_timings 2048 1 58 183 183 240 1 3 3 16 0 0 0 60 0 38893489 1" "1870" "155" "224" "8"

			elif [[ $rom_resolution_height == "240" ]] ; then			
				# test with ddonpach 320 x 240
				set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1810" "70" "226" "7"

			elif [[ $rom_resolution_height == "232" ]] ; then			
				# test with kyukyoku sentai dadandarn 320 x 232 
				set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1810" "70" "226" "7"

			elif [[ $rom_resolution_height == "256" ]] ; then	
				# test astro fighter 256 x 256
				# test pound for pound 384 x 256
				if ! [[ "$crt_profile" == "consumer" ]] ; then
					set_res "hdmi_timings 1920 1 180 192 308 256 1 8 5 18 0 0 0 55 0 41041000 1" "1920" "0" "256" "0"
				else
					set_res "hdmi_timings 1920 1 34 192 254 256 1 5 5 16 0 0 0 56 0 37900800 1" "1830" "53" "226" "15"
				fi

			else
				# main resolution from michael 
				#set_res "hdmi_timings 1600 1 41 157 236 240 1 4 3 15 0 0 0 60 0 32000000 1" "1600" "0" "240" "0"

				if ! [[ "$crt_profile" == "consumer" ]] ; then
					set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
				else
					set_res_consoles
				fi
			fi
		fi

#############################################################################################################
#
#
#   Handling of horizontal games
#
#
#############################################################################################################

	elif ([[ $rom_resolution_width == "384" ]] ||
		[[ $rom_resolution_width == "320" ]]) && 
	    [[ $rom_resolution_height == "224" ]] ; then
		# 384x224 (5x H int scale) (CPS1, CPS2, CPS3)
		# 320x224 (6x H int scale) (Neo Geo, Sega System 16, Sega System 18, Sega X Board, Sega Y Board)
		# H Sync 15.72 kHz
        # V Sync 60 Hz
		# Test with street fighter 3 384 x 224

		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 98 192 190 224 1 13 7 18 0 0 0 60 0 37728000 1" "1920" "0" "224" "0"
		else
			set_res "hdmi_timings 2048 1 58 183 183 240 1 3 3 16 0 0 0 60 0 38893489 1" "1870" "155" "224" "8" 
		fi
		
    elif ([[ $rom_resolution_width == "512" ]] ||
    	  [[ $rom_resolution_width == "256" ]] ||
    	  [[ $rom_resolution_width == "288" ]] ||
    	  [[ $rom_resolution_width == "304" ]]) && 
          [[ $rom_resolution_height == "224" ]] ; then
    	# 512x224 (3x H int scale + 384 pixels) (Sega System 1, Sega System 2)
    	# 256x224 (7x H int scale + 128 pixels) ()
    	# 288x224 (6x H int scale + 192 pixels) (Konami)
    	# 304x224 (6x H int scale + 96 pixels) (Konami)
    	# H Sync 15.72 kHz
        # V Sync 60 Hz
    	# Test with Airwolf 288 x 224

		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 98 192 190 224 1 13 7 18 0 0 0 60 0 37728000 1" "1920" "0" "224" "0"
		else
			set_res "hdmi_timings 2048 1 58 183 183 240 1 3 3 16 0 0 0 60 0 38893489 1" "1870" "155" "224" "8" 
		fi

	elif ([[ $rom_resolution_width == "256" ]] ||
    	  [[ $rom_resolution_width == "319" ]]) && 
          [[ $rom_resolution_height == "240" ]] ; then
        # 256x240 (7x H int scale + 128 pixels) (Data East)
        # 319x240 (6x H int scale + 6 pixels) (Data East)
    	# H Sync 15.72 kHz
        # V Sync 60 Hz
    	# test with bad dudes 256 x 240
		
		#vcgencmd hdmi_timings 1920 1 98 192 190 240 1 3 7 12 0 0 0 60 0 37730000 1
		set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1810" "70" "226" "7"

	elif ([[ $rom_resolution_width == "320" ]] ||
    	  [[ $rom_resolution_width == "384" ]]) && 
          [[ $rom_resolution_height == "240" ]] ; then
        # 320x240 (6x H int scale) (Data East)
        # 384x240 (5x H int scale) (Taito)
    	# H Sync 15.72 kHz
        # V Sync 60 Hz
    	# tested with chiller 320 x 240 

		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 98 192 190 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1820" "60" "226" "7"
		fi		

	elif ([[ $rom_resolution_width == "320" ]]) && 
          [[ $rom_resolution_height == "232" ]] ; then
        # 320x232 (6x H int scale) (Taito)
    	# H Sync 15.72 kHz
        # V Sync 60 Hz
    	# tested with darius gaiden 320x232

		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 98 192 190 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1820" "60" "226" "7"
		fi	
		
    elif ([[ $rom_resolution_width == "384" ]]) && 
          [[ $rom_resolution_height == "256" ]] ; then
        # [WIP]
        # 384x256 (5x H int scale) ()
		# H Sync 15.79 kHz
        # V Sync 55 Hz
		# tested with dragon breed 384 x 256

		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 100 320 260 254 1 1 3 36 0 0 0 53.20 0 40670000 1" "1920" "0" "224" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 256 1 5 5 16 0 0 0 56 0 37900800 1" "1830" "53" "226" "15"
		fi
		
	elif ([[ $rom_resolution_width == "400" ]]) && 
          ([[ $rom_resolution_height == "256" ]] ||
		  [[ $rom_resolution_height == "224" ]] ||
		  [[ $rom_resolution_height == "240" ]] ||
		  [[ $rom_resolution_height == "248" ]] ||
		  [[ $rom_resolution_height == "254" ]] ||
		  [[ $rom_resolution_height == "256" ]] ||
		  [[ $rom_resolution_height == "280" ]] ||
    	  [[ $rom_resolution_height == "300" ]]); then
		# added for 400 width resolutions like mortal kombat
		# WIP test heigth resolutions
		# 400 width like mortal kombat
		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 93 320 267 254 1 7 3 30 0 0 0 53.20 0 40670000 1" "1920" "0" "240" "0"
		else
			set_res_consoles
		fi

	else 
		log "Something else arcade timings"
		if ! [[ "$crt_profile" == "consumer" ]] ; then
			set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
		else
			set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1820" "60" "226" "7"
		fi
	fi
	# end of resolution setting for arcade emulators

elif [[ "$system" == "megadrive" ]] ||
           [[ "$system" == "snes" ]] ||
		   [[ "$system" == "genesis" ]] ||
           [[ "$system" == "nes" ]]  ; then
	log "timings for megadrive, snes, genesis, nes"
	set_res_consoles
elif [[ "$system" == "psx" ]] ||
           [[ "$system" == "pce" ]] ||
		   [[ "$system" == "n64" ]] ; then
	log "timings for psx, pce, n64"
	set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
else
	log "Running else timings"

	if ! [[ "$crt_profile" == "consumer" ]] ; then
		#set_res "hdmi_timings 1600 1 41 157 236 240 1 4 3 15 0 0 0 60 0 32000000 1" "1600" "0" "240" "0"
		set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1920" "0" "240" "0"
	else
		set_res "hdmi_timings 1920 1 34 192 254 240 1 3 7 12 0 0 0 60 0 37730000 1" "1820" "60" "226" "7"
	fi
fi
	
	

}
