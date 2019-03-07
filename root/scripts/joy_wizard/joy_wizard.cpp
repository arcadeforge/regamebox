
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL.h>
#include <time.h>
#include <SDL/SDL_ttf.h>
#include <SDL/SDL_image.h>



FILE *ll_config;
FILE *ra_config;

void wait (float seconds) {
    clock_t wait;
    wait = clock();
    while (clock() < (wait + seconds * CLOCKS_PER_SEC));

}

void emptyEvents () {
    //wait (2);
    SDL_JoystickEventState(SDL_DISABLE);
    SDL_JoystickEventState(SDL_ENABLE);
}


char* ask_gamepad (bool _running) {
    static char arr[] = "test";
    int count = 0;
    int limit = 10;

    while (_running) {
 	    SDL_Event event;
		while(SDL_PollEvent(&event) != 0 ) {
            switch(event.type) {
        	    //case SDL_KEYDOWN:
        	    //    printf("key down\n");
        	    //    break;
        	    case SDL_QUIT:
        	        printf("quit\n");
        	        _running = false;
        	        return arr;
        	    case SDL_JOYAXISMOTION:
                    for (count = 0; count <= limit; ++count)
                    {
            	        if( event.jaxis.axis == count ) {
            	            if( event.jaxis.value < -32000) {  
            		            printf("-%d axis\n", count);
                    		    sprintf (arr, "%d", count);
                                return arr;
            		        }
            				else if( event.jaxis.value > 32000 ) {  
                    		    printf("+%d axis\n", count); 
                    		    sprintf (arr, "%d", count);
                                return arr;
                            }
                        }
                    }
        		    break;
                case SDL_JOYBUTTONDOWN:  /* Handle Joystick Button Presses */
                    count = 0;
                    limit = 30;
                    for (count = 0; count <= limit; ++count)
                    {
                        if ( event.jbutton.button == count ) {
                	        printf("button %d\n", count);
                  		    sprintf (arr, "%d", count);
                            return arr;
                        }
                    }
                    break;
                case SDL_JOYHATMOTION:
                    //printf ("joyhat not supported yet");
                    //printf("Joystick %d hat %d value:",
                    //     event.jhat.which, event.jhat.hat);
                    if (event.jhat.value == SDL_HAT_CENTERED) {
                        printf("hat centered");
                        //return arr;
                    }
                    if (event.jhat.value & SDL_HAT_UP) {
                        printf("hat up\n");
                        printf ("hat %s\n", SDL_HAT_UP);
                        //return arr;
                    }
                    if (event.jhat.value & SDL_HAT_RIGHT) {
                        printf ("hat %s\n", SDL_HAT_RIGHT);
                        //return arr;
                    }
                    if (event.jhat.value & SDL_HAT_DOWN) {
                        printf ("hat %s\n", SDL_HAT_DOWN);
                        //return arr;
                    }    
                    if (event.jhat.value & SDL_HAT_LEFT) {
                        printf("hat %s\n", SDL_HAT_LEFT);
                        //return arr;
                    }

                    break;

            } //switch
        } //while
    } //while

    return arr;
}



int main(int argc, char *argv[]){

    static char str[] ="test" ;

	printf("Welcome to the joystick wizard for the lemonlauncher menu.\n");

    //SDL_InitSubSystem(SDL_INIT_VIDEO);
    //SDL_InitSubSystem(SDL_INIT_JOYSTICK);
    //SDL_INIT_JOYSTICK;

    SDL_Surface *screen = NULL;
    SDL_Surface *image = NULL;
    const SDL_VideoInfo *videoInfo = NULL;

    /*-----------------------------------------------------------------*/
    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        fprintf(stderr, "SDL_Init failed - %s\n", SDL_GetError());
        return 1;
    }


    videoInfo = SDL_GetVideoInfo();

    if (videoInfo == 0)
    {
        fprintf(stderr, "SDL_GetVideoInfo failed - %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    /*-----------------------------------------------------------------*/

    image = IMG_Load("img/down.png");

    if (!image)
    {
        fprintf(stderr, "IMG_Load failed - %s\n", IMG_GetError());
        SDL_Quit();
        return 1;
    }

    /*-----------------------------------------------------------------*/

    screen = SDL_SetVideoMode(image->w,
                              image->h,
                              videoInfo->vfmt->BitsPerPixel,
                              SDL_HWSURFACE);

    if (!screen)
    {
        fprintf(stderr, "SetVideoMode failed - %s\n", SDL_GetError());
        SDL_FreeSurface(image);
        SDL_Quit();
        return 1;
    }

    SDL_BlitSurface(image, 0, screen, 0);
    
    //SDL_Delay(1000);

    ll_config = fopen ("/root/config/lemonlauncher_custom_usb.conf", "w"); 
    ra_config = fopen ("/root/usb_controller/custom_usb", "w"); 

    //ll_config = fopen ("test.conf", "w"); 

    if (SDL_Init( SDL_INIT_JOYSTICK ) < 0) {
        fprintf(stderr, "Couldn't initialize SDL: %s\n", SDL_GetError());
        printf("Couldn't initialize SDL: %s\n", SDL_GetError());
        exit(1);
    }
	
    SDL_Joystick *joy;
    // Check for joystick
    
    if(SDL_NumJoysticks()>0) {
	    // Open joystick
	    SDL_JoystickEventState(SDL_ENABLE);
	    joy=SDL_JoystickOpen(0);
		  
	    if (joy) {
	        printf("Opened Joystick 0\n");
    		printf("Name: %s\n", SDL_JoystickName(0));
    		printf("Number of Axes: %d\n", SDL_JoystickNumAxes(joy));
    		printf("Number of Buttons: %d\n", SDL_JoystickNumButtons(joy));
    		printf("Number of Balls: %d\n", SDL_JoystickNumBalls(joy));
	    } else {

    		printf("Could not open Joystick!\n");

            exit(0);

	    }

	    bool _running = true;

        printf("Press Joystick / Button for List Down, ie Joy down\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_down=%s\n", str);      
        fprintf (ra_config, "input_player1_down_btn = \"%s\"\n", str);
        printf ("down %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/up.png");
        SDL_BlitSurface(image, 0, screen, 0);
                        
        printf("Press Joystick / Button for List Up, ie Joy up\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_up=%s\n", str);      
        fprintf (ra_config, "input_player1_up_btn = \"%s\"\n", str);
        printf ("up %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/right.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Joystick / Button for pagewise Down, ie joy right\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_pgdown=%s\n", str);      
        fprintf (ra_config, "input_player1_right_btn = \"%s\"\n", str);
        printf ("right %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/left.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Joystick / Button for pagewise Up, ie joy left\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_pgup=%s\n", str);      
        fprintf (ra_config, "input_player1_left_btn = \"%s\"\n", str);
        printf ("left %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_b.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for activate item, ie button 1\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_select=%s\n", str);      
        fprintf (ra_config, "input_player1_b_btn = \"%s\"\n", str);
        printf ("activate, b %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_a.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for deactivate item, ie button 2\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_back=%s\n", str);      
        fprintf (ra_config, "input_player1_a_btn = \"%s\"\n", str);
        printf ("back, a %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_l.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for alphabetical up, ie button left shoulder\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_alphamod_up=%s\n", str);      
        fprintf (ra_config, "input_player1_l_btn = \"%s\"\n", str);
        printf ("alpha up, left shoulder %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_r.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for alphabetical down, ie button right shoulder\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ll_config, "joy_alphamod_down=%s\n", str);      
        fprintf (ra_config, "input_player1_r_btn = \"%s\"\n", str);
        printf ("alpha down, right shoulder %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/select.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for Hotkey, ie button select\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ra_config, "input_enable_hotkey_btn = \"%s\"\n", str);
        fprintf (ra_config, "input_player1_select_btn = \"%s\"\n", str);
        printf ("select, hotkey %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/start.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for Game Exit, ie button start\n");
        printf("This button must be used with the hotkey.\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ra_config, "input_exit_emulator_btn = \"%s\"\n", str);
        fprintf (ra_config, "input_player1_start_btn = \"%s\"\n", str);
        printf ("start, hotkey + exit %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_y.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press Button for Retroarch Menu, ie left upper button\n");
        printf("This button must be used with the hotkey.\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ra_config, "input_menu_toggle_btn = \"%s\"\n", str);
        fprintf (ra_config, "input_player1_y_btn = \"%s\"\n", str);
        printf ("Y, hotkey + ra menu %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
        image = IMG_Load("img/button_x.png");
        SDL_BlitSurface(image, 0, screen, 0);

        printf("Press right upper button\n");
        printf("This is button x on a snes pad (fire 2).\n");
        strcpy(str, ask_gamepad (_running));
        fprintf (ra_config, "input_player1_x_btn = \"%s\"\n", str);
        printf ("X %s\n", str);
        emptyEvents();

        SDL_FreeSurface(image);
//        image = IMG_Load("img/help.png");
//        SDL_BlitSurface(image, 0, screen, 0);
        

    } 
    printf("\n\nYour settings are stored!\n");

    fclose (ll_config);

    fprintf (ra_config, "input_menu_toggle = \"alt\"\n");
    fprintf (ra_config, "input_enable_hotkey = \"num1\"\n");
    fprintf (ra_config, "input_exit_emulator = \"ctrl\"\n");
    
    fclose (ra_config);

	if(SDL_JoystickOpened(0)) {
		SDL_JoystickClose(joy);
    }

    SDL_Quit();

} //main

