# *************************************
# Volume setting script
# Jochen Zurborg - 14.07.2017
# *************************************


SAVE_FILE="/root/config/volume.conf"
VOLUME="100"

if [ -e $SAVE_FILE ]; then
    VOLUME=$(cat $SAVE_FILE)
else
    echo "100" > $SAVE_FILE
fi

function kill_running(){
    if [ "$(pgrep -x "$1")" ];
    then
        echo "Killing off $1"
    killall $1
    fi
}
 

function rm_xist()
{
    if [ -e $1 ]; then
        rm $1
    fi

}

# Generate hdmi_timings | Main menu / loop
set_volume ()
{
	clear
	echo "******************************************"
	echo "* Set Game Volume with Joystick Player 1 *"
        echo "* Quit with Player 1 Start (Key1)        *"
	echo "******************************************"
        echo "* Game Menu Music Volume will be reduced *"
	echo "******************************************"
	echo "****              "$VOLUME"              ****"
	echo "******************************************"
	

	
	# Detect cursor/arrow keys
	while true
 	do
	
	amixer sset PCM,0 $VOLUME% &> /dev/null
	
	read -r -sn1 input

 	case $input in
 
	A) move_up ;;		# up arrow pressed
 	B) move_down ;;		# down arrow pressed
	C) move_right ;;	# right arrow pressed
 	D) move_left ;;		# left arrow pressed

	esac

	if [ "$input" == "1" ]; then
                rm_xist $SAVE_FILE
		echo "$VOLUME" > $SAVE_FILE
                kill_running mpg123
                exit
	fi
	
	done
}



# Increase horizontal front porch while decreasing back porch
move_left ()
{
	if [ "$VOLUME" == "0" ]; then
		VOLUME="0"
	else
		((VOLUME--))
	fi
	set_volume
}

# Decrease horizontal front porch while increasing back porch
move_right ()
{
	if [ "$VOLUME" == "100" ]; then
		VOLUME="100"
	else
		((VOLUME++))
	fi
	set_volume
}

# Increase vertical front porch while decreasing back porch
move_up ()
{
	if [ "$VOLUME" == "100" ]; then
		VOLUME="100"
	else
		((VOLUME++))
	fi
	set_volume
}

# Decrease vertical front porch while increasing back porch
move_down ()
{
	if [ "$VOLUME" == "0" ]; then
		VOLUME="0"
	else
		((VOLUME--))
	fi
	set_volume
}

# Start of program
if [ -f /root/menu-audio/arcade.pls ]; then
	mpg123 -q -@ /root/menu-audio/arcade.pls &
else  
        echo "no /root/menu-audio/arcade.pls file found"
fi
set_volume

