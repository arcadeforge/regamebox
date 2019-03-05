import pygame
import os
import sys
import time
#debug = True
debug = False


comp_pHActive = 0.833
comp_pHSyncWidth = 0.073
comp_pVSyncWidth = 0.03

pHActive = 0.745
pHSyncWidth = 0.117
pVSyncWidth = 0.03

#screen a little bit to the left
#pHActive = 0.77
#pHSyncWidth = 0.092
#pVSyncWidth = 0.03

pHPos = 0
pVPos = 0
h_pos = 0
v_pos = 0
base_h_fp = 0
base_v_fp = 0
base_v_bp = 0
oneTime = True


freq_vert_60p = 15720
freq_vert_50p = 15600

poverscan = 0

# hdmi-timings
x_res = 320
h_fp = 12
h_sync = 22
h_bp = 52
y_res = 240
v_fp = 5
v_sync = 7
v_bp = 11
freq = 60
pixel_clock = 6400000

# emulation of framebuffer
cv_width = 320
cv_height = 240
cv_x = 0
cv_y = 0

# overscan
o_top=0 
o_bottom=0
o_left=0
o_right=0

#free_pixel_clock = 38400000
free_pixel_clock = 31260000


#scaling for gui elements
(base_width, base_height) = (320,240)
sc_x = 1
sc_y = 1
aspect_ratio = 1
#screen = pygame.display.set_mode((x_res,y_res))

max_show = 30

# File interface
file = open ("hdmi_timing.txt", "r")
file_sav = open ("hdmi_timing_save.txt", "a") 
log_file = open ("log.txt", "a")


test_pic = ["align.png", "align_240p.png", "align_256p.png"]

fc_r = 255
fc_g = 255
fc_b = 255

fc_arr = [[255,255,255], [255, 0, 0] , [0, 255, 0], [0, 0, 255], [255, 255, 0], [0, 255, 255], [255, 0, 255], [0,0,0]]

lcd_x = 640
lcd_y = 480

name = ""
emu = ""
system = ""

calibrateStep = 1
# define a main function
def main():
    global aspect_ratio
    global sc_x
    global sc_y
    global screen 
    global fc_r
    global fc_g 
    global fc_b 

    global x_res
    global y_res
    global freq
    global poverscan
    global pixel_clock
    global cv_width
    global cv_height
    global cv_x
    global cv_y

    global calibrateStep

    bShowAll = True
    
    # read_hdmi_timings (file)

    if len(sys.argv) > 1:
        log ("=============START CALIBRATE SCREEN===========")
        log ("reading console parameters")
        x_res = int(sys.argv[1])    
        y_res = int(sys.argv[2])    
        freq = float(sys.argv[3])
        # poverscan = int(sys.argv[4])
        # showMode = 1 is show all info
        # showMode = 2 is show only calibration monitor
        # 
        showMode = int(sys.argv[4])
        if showMode == 1:
            bShowAll = True
        elif showMode == 2:
            bShowAll = False
            bShowCalScreen = True
            calibrateStep = 1
            read_calibration_conf()
            
        # if values are given via console, then 
        # use computation model        
        bCompute = True
        
    else:
        log ("reading hdmi_timings.txt")
        read_hdmi_timings (file)
        bCompute = False
        
    read_test_pics()


    cv_width = round (x_res - x_res * poverscan / 100)
    cv_height = round (y_res - y_res * poverscan / 100)
    #cv_height = 228

    cv_x = round ((x_res - cv_width) / 2)
    cv_y = round ((y_res - cv_height) / 2)

    if debug:
        cv_width = lcd_x
        cv_height = lcd_y
        cv_x = 0
        cv_y = 0

#    cv_width = int(sys.argv[4])
#    cv_heigth = int(sys.argv[5])
#    cv_x = int(sys.argv[6])
#    cv_y = int(sys.argv[7])
    
    log ("xres: " + str(x_res))     
    log ("yres: " + str(y_res))     
    log ("freq: " + str(freq))     

    if bCompute:
        computeTimings(x_res, y_res)
        _h_rate = computeHFREQ(x_res, h_fp, h_sync, h_bp, pixel_clock)
        _v_rate = computeVFREQ(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, pixel_clock)
        log ("compute timings")
        log ("h_rate: " + str(_h_rate))     
        log ("v_rate: " + str(_v_rate))     

    _clock = computePixelClock(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)
   
    log ("pclk: " + str(_clock))     
    
    # in compute mode no pclk is given, so compute it.
    if bCompute:
        pixel_clock = _clock


    getOverscan()

    if debug:
        log ("set fbset")
    else:
        os.popen("fbset -xres " + str(x_res) + " -yres " + str(y_res))
        os.popen("sleep 0.3")


    # initialize the pygame module
    pygame.init()
    pygame.mouse.set_visible(0)

    # needed for some text and pos scaling 
    if debug:
       log ("scale font")
       screen = pygame.display.set_mode((lcd_x,lcd_y), pygame.FULLSCREEN)
       sc_x = lcd_x / base_width
       sc_y = lcd_y / base_height
       aspect_ratio = lcd_x / lcd_y
    else:
        screen = pygame.display.set_mode((0,0), pygame.FULLSCREEN)
        sc_x = x_res / base_width
        sc_y = y_res / base_height
        aspect_ratio = x_res / y_res

    show = False
    image = pygame.image.load("./test_pic/" + test_pic[0])

    # take new res now 
    setResolution (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock)
    computeCalibration ()

    saveAct()

    # define a variable to control the main loop
    running = True
    ctr_pic = 0
    ctr_fc = 0

    # key repeat
#    pygame.key.set_repeat(10, 10)

    clock = pygame.time.Clock()
        
    bShowCalibration = False

    # main loop
    while running:
        clock.tick(60)
        
        pressed = pygame.key.get_pressed()

        # event handling, gets all event from the eventqueue
        for event in pygame.event.get():

            # only do something if the event is of type QUIT
            if event.type == pygame.QUIT:
                # change the value to False, to exit the main loop
                running = False

            if event.type == pygame.KEYDOWN:
                if bShowCalScreen:
                    # order important
                    if event.key == pygame.K_1 and calibrateStep == 3:
                        calibrateStep = 4
                        log ("Calibrate Step 3 - finetune pos")
                        log ("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
                        log ("%s;%s;%s;%s;%s" % (pHActive, pHSyncWidth, pVSyncWidth, pHPos, pVPos))

                    if event.key == pygame.K_1 and calibrateStep == 2:
                        calibrateStep = 3

                        log ("Calibrate Step 2 - Change SyncWidth")
                        log ("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
                        log ("%s;%s;%s;%s;%s" % (pHActive, pHSyncWidth, pVSyncWidth, pHPos, pVPos))


                    if event.key == pygame.K_1 and calibrateStep == 1:
                        calibrateStep = 2
                        log ("Calibrate Step 1 - Change pHActive")
                        log ("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
                        log ("%s;%s;%s;%s;%s" % (pHActive, pHSyncWidth, pVSyncWidth, pHPos, pVPos))


                # change font color
                if event.key == pygame.K_i:
                    ctr_fc += 1
                    if ctr_fc == len(fc_arr):
                       ctr_fc = 0
                    
                    fc_r = fc_arr[ctr_fc][0]
                    fc_g = fc_arr[ctr_fc][1]
                    fc_b = fc_arr[ctr_fc][2]
                    
                # change test picture
                if event.key == pygame.K_a:
                    ctr_pic += 1
                    if ctr_pic == len(test_pic):
                       ctr_pic = 0
                    image = pygame.image.load("./test_pic/" + test_pic[ctr_pic])

                    if ctr_pic == 0: 
                        fc_r = 255
                        fc_g = 255
                        fc_b = 255
                    else:
                        fc_r = 0
                        fc_g = 0
                        fc_b = 0

                        

        if bShowAll:
            # move picture
            if not(pressed[pygame.K_f]) and not(pressed[pygame.K_g]) and not(pressed[pygame.K_p]) and not(pressed[pygame.K_o]):
                if pressed[pygame.K_RIGHT]:
                    move ( "right" )
                if pressed[pygame.K_LEFT]:
                    move ( "left" )
                if pressed[pygame.K_DOWN]:
                    move ( "down" )
                if pressed[pygame.K_UP]:
                    move ( "up" )

            # move customvideo (similar to retroarch custom video) 
            if pressed[pygame.K_f] and pressed[pygame.K_UP]:
                setCustomVideo ( "cv_up" )
            if pressed[pygame.K_f] and pressed[pygame.K_DOWN]:
                setCustomVideo ( "cv_down" )
            if pressed[pygame.K_f] and pressed[pygame.K_LEFT]:
                setCustomVideo ( "cv_left" )
            if pressed[pygame.K_f] and pressed[pygame.K_RIGHT]:
                setCustomVideo ( "cv_right" )

            # resize customvideo
            if pressed[pygame.K_g] and pressed[pygame.K_UP]:
                setCustomVideo ( "cv_y_plus" )
            if pressed[pygame.K_g] and pressed[pygame.K_DOWN]:
                setCustomVideo ( "cv_y_minus" )
            if pressed[pygame.K_g] and pressed[pygame.K_LEFT]:
                setCustomVideo ( "cv_x_minus" )
            if pressed[pygame.K_g] and pressed[pygame.K_RIGHT]:
                setCustomVideo ( "cv_x_plus" )


            # increase freq
            if pressed[pygame.K_r] and pressed[pygame.K_PLUS]:
                move ( "increase_freq" )
            # decrease freq
            if pressed[pygame.K_r] and pressed[pygame.K_MINUS]:
                move ( "decrease_freq" )


            # increase xres
            if pressed[pygame.K_x] and pressed[pygame.K_PLUS]:
                move ( "increase_xres" )
            # decrease xres
            if pressed[pygame.K_x] and pressed[pygame.K_MINUS]:
                move ( "decrease_xres" )

            # increase yres
            if pressed[pygame.K_y] and pressed[pygame.K_PLUS]:
                move ( "increase_yres" )

            # decrease yres
            if pressed[pygame.K_y] and pressed[pygame.K_MINUS]:
                move ( "decrease_yres" )

            # change porches and sync_tips
            if pressed[pygame.K_1] and pressed[pygame.K_PLUS]:
                move ( "increase_hfp" )
            if pressed[pygame.K_1] and pressed[pygame.K_MINUS]:
                move ( "decrease_hfp" )
            if pressed[pygame.K_2] and pressed[pygame.K_PLUS]:
                move ( "increase_hsync" )
            if pressed[pygame.K_2] and pressed[pygame.K_MINUS]:
                move ( "decrease_hsync" )
            if pressed[pygame.K_3] and pressed[pygame.K_PLUS]:
                move ( "increase_hbp" )
            if pressed[pygame.K_3] and pressed[pygame.K_MINUS]:
                move ( "decrease_hbp" )

            if pressed[pygame.K_4] and pressed[pygame.K_PLUS]:
                move ( "increase_vfp" )
            if pressed[pygame.K_4] and pressed[pygame.K_MINUS]:
                move ( "decrease_vfp" )
            if pressed[pygame.K_5] and pressed[pygame.K_PLUS]:
                move ( "increase_vsync" )
            if pressed[pygame.K_5] and pressed[pygame.K_MINUS]:
                move ( "decrease_vsync" )
            if pressed[pygame.K_6] and pressed[pygame.K_PLUS]:
                move ( "increase_vbp" )
            if pressed[pygame.K_6] and pressed[pygame.K_MINUS]:
                move ( "decrease_vbp" )
            
            # change overscan
            if pressed[pygame.K_p] and pressed[pygame.K_UP]:
                setOverscan ( "increase_o_bottom" )
            if pressed[pygame.K_p] and pressed[pygame.K_DOWN]:
                setOverscan ( "decrease_o_bottom" )
            if pressed[pygame.K_o] and pressed[pygame.K_DOWN]:
                setOverscan ( "increase_o_top" )
            if pressed[pygame.K_o] and pressed[pygame.K_UP]:
                setOverscan ( "decrease_o_top" )
            
            if pressed[pygame.K_p] and pressed[pygame.K_LEFT]:
                setOverscan ( "increase_o_right" )
            if pressed[pygame.K_p] and pressed[pygame.K_RIGHT]:
                setOverscan ( "decrease_o_right" )
            if pressed[pygame.K_o] and pressed[pygame.K_RIGHT]:
                setOverscan ( "increase_o_left" )
            if pressed[pygame.K_o] and pressed[pygame.K_LEFT]:
                setOverscan ( "decrease_o_left" )


            if pressed[pygame.K_b] and pressed[pygame.K_PLUS]:
                calibrateScreen ( "increase_pHActive" )
            if pressed[pygame.K_b] and pressed[pygame.K_MINUS]:
                calibrateScreen ( "decrease_pHActive" )
            if pressed[pygame.K_n] and pressed[pygame.K_PLUS]:
                calibrateScreen ( "increase_pHSyncWidth" )
            if pressed[pygame.K_n] and pressed[pygame.K_MINUS]:
                calibrateScreen ( "decrease_pHSyncWidth" )
            if pressed[pygame.K_m] and pressed[pygame.K_PLUS]:
                calibrateScreen ( "increase_pVSyncWidth" )
            if pressed[pygame.K_m] and pressed[pygame.K_MINUS]:
                calibrateScreen ( "decrease_pVSyncWidth" )

            #undo
            if pressed[pygame.K_u]:
                undo()
                show = True
                show_ctr = 0
                msg_txt = "Undo!"



        #compute porches and sync to center
        if pressed[pygame.K_c]:
            # undo possible
            saveAct()
            computeTimings(x_res, y_res)
            show = True
            show_ctr = 0
            msg_txt = "Computed h timings taken! Undo with u"


        # getting to nerdy? just show on purpose
        if pressed[pygame.K_k]:
            bShowCalibration = True
        if pressed[pygame.K_l]:
            bShowCalibration = False

        # save timings
        if pressed[pygame.K_s]:
            save_hdmi_timings(file_sav)
            show = True
            show_ctr = 0
            msg_txt = "Timings was stored to hdmi_timings_save.txt"

        if bShowCalScreen:
            running = calScreenStates(pressed)


        # quit
        if pressed[pygame.K_q]:
            #pygame.quit()
            #os.popen("fbset -depth 8 && fbset -depth 16 -xres 1280 -yres 720")
            #sys.exit(0)
            file_sav.close()
            file.close()
            log_file.close()
            running = False

        screen.fill((0,0,0)) 

        #screen.blit(image,(0,0))
        #screen.blit(pygame.transform.scale(image, (x_res, y_res)),(0,0))

        screen.blit(pygame.transform.scale(image, (cv_width, cv_height)),(cv_x,cv_y))

        # show short time message for user
        if show == True:
            show_ctr = show_ctr + 1
            txt = msg_txt
            text_print (txt, 20, 110, fc_r, fc_g, fc_b, 12)
            if show_ctr == max_show:
                show = False
                msg_txt = ""

        if bShowCalScreen:
            txt = ("Calibration of Screen")
            text_print (txt, 20, 20, fc_r, fc_g, fc_b, 18)
            txt = ("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
            text_print (txt, 20, 50, fc_r, fc_g, fc_b, 12)

            txt = ("pHActive %s pHSync %s pVsync %s  - Distribution" % (pHActive, pHSyncWidth, pVSyncWidth))
            text_print (txt, 20, 60, fc_r, fc_g, fc_b, 12)

            txt = ("Key Q Abort calibration of screen")
            text_print (txt, 20, 220, fc_r, fc_g, fc_b, 12)



        if bShowCalibration:
            computeCalibration ()
            txt = ("pHActive %s pHSync %s pVsync %s  - Distribution" % (pHActive, pHSyncWidth, pVSyncWidth))
            text_print (txt, 20, 90, fc_r, fc_g, fc_b, 12)

            txt = ("pHActive %s pHSync %s pVsync %s  - DistrComputed" % (round (comp_pHActive,3), round(comp_pHSyncWidth, 3), round(comp_pVSyncWidth,3)))
            text_print (txt, 20, 100, fc_r, fc_g, fc_b, 12)


        pixel_clock = computePixelClock(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)
        
        _vertRate = computeVFREQ(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, pixel_clock)
        _rate = computeHFREQ(x_res, h_fp, h_sync, h_bp, pixel_clock)
        # ok, compute pclk with no fixed pclk 
        real_clock = computeRealPixelClock(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)

        if bShowCalScreen:
            txt = ("HoriRate %s VertiRate %s Pixel Clock %s" % (_rate, _vertRate, real_clock))
            text_print (txt, 20, 40, fc_r, fc_g, fc_b, 12)


        # now show this fixed pclock from rpi
        if bShowAll:
            if real_clock != pixel_clock:
                real_vertRate = computeVFREQ(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, real_clock)
                real_rate = computeHFREQ(x_res, h_fp, h_sync, h_bp, real_clock)
                txt = ("HoriRate real/deviation %s - %s" % (real_rate, _rate))
                text_print (txt, 20, 40, fc_r, fc_g, fc_b, 12)

                txt = ("VertiRate real/deviation %s - %s" % (real_vertRate, _vertRate))
                text_print (txt, 20, 50, fc_r, fc_g, fc_b, 12)

                txt = ("Pixel Clock real/deviation %s - %s" % (real_clock, pixel_clock))
                text_print (txt, 20, 60, fc_r, fc_g, fc_b, 12)
            else:
                txt = ("HoriRate %s" % (_rate))
                text_print (txt, 20, 40, fc_r, fc_g, fc_b, 12)

                txt = ("VertiRate %s" % (_vertRate))
                text_print (txt, 20, 50, fc_r, fc_g, fc_b, 12)

                txt = ("Real Pixel Clock %s" % (real_clock))
                text_print (txt, 20, 60, fc_r, fc_g, fc_b, 12)


            printHelp()

        if not bShowAll:
            printCalibrate()

        pygame.display.flip()


def log(msg):
    log_file.write(msg)
    log_file.write("\n")

def saveAct():
    global file_act 
    file_act = open ("act.txt", "w").close()
    file_act = open ("act.txt", "w")
    file_act.write("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1 #%s#%s#%s#%s#%s#%s#%s#%s#\n" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock, cv_width, cv_x, cv_height, cv_y, o_top, o_bottom, o_left, o_right))
    file_act.close()

def undo():
    #global file_act 
    file_act = open ("act.txt", "r")
    read_hdmi_timings(file_act)

def save_hdmi_timings(file):
    file.write("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1 #%s#%s#%s#%s#%s#%s#%s#%s test # test # test\n" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock, cv_width, cv_x, cv_height, cv_y, o_top, o_bottom, o_left, o_right))
    file.write("Modeline \"%sx%s_%s\" %s %s %s %s %s %s %s %s %s -hsync -vsync\n" % (x_res, y_res, freq, pixel_clock /1000000, x_res, x_res+h_fp, x_res+h_fp+h_sync, x_res+h_fp+h_sync+h_bp, y_res, y_res+v_fp, y_res+v_fp+v_sync, y_res+v_fp+v_sync+v_bp))
    file.write("Customvideo: Size (%s, %s) Pos (%s, %s)\n" % (cv_width, cv_height, cv_x, cv_y))
    file.write("Overscan: leftup(%s, %s) rightdown (%s, %s)\n" % (o_top, o_bottom, o_left, o_right))
    file.write("Monitor Calibration: pHActive %s, pHSyncWidth %s, pVSyncWidth %s\n" % (round(comp_pHActive,3), round(comp_pHSyncWidth,3), round(comp_pVSyncWidth,3)))
    file.write("=========================================================\n")


def read_test_pics():
    global test_pic
    
    os.system("ls test_pic > test_pics.txt")
    file = open ("test_pics.txt", "r")

    test_pic_lines = file.readlines()
    test_pic = []
    for l in test_pic_lines:
        test_pic.append(l.strip())
    #print (test_pic)

def read_calibration_conf():

    fCalibration = open ("calibration.conf", "r")

    #pHActive = 0.745   
    #pHSyncWidth = 0.117
    #pVSyncWidth = 0.03

    global pHActive   
    global pHSyncWidth
    global pVSyncWidth
    global pHPos
    global pVPos
    global h_pos
    global v_pos
    
    line = fCalibration.readline()
 
    values = line.split(";")
   
    pHActive = round (float(values[0]), 4)
    pHSyncWidth = round (float(values[1]), 4)
    pVSyncWidth = round (float(values[2]), 4)
    pHPos = round (float(values[3]), 4)
    pVPos = round (float(values[4]), 4)

    fCalibration.close()
    

    log ("Reading pHSyncWidth %s and pVSyncWidth %s" % (pHSyncWidth, pVSyncWidth)) 
    log ("Reading pHPos %s and pVPos %s" % (pHPos, pVPos)) 
    # round up + 0.5
    h_pos = round ((x_res * pHPos / 100) + 0.5)
    v_pos = round ((y_res * pVPos / 100) + 0.5)
    #v_pos = round ((100 * pVPos / y_res) + 0.5)
    log ("Computed HPos %s and VPos %s" % (h_pos, v_pos)) 


def read_hdmi_timings(file):

    global x_res
    global h_fp 
    global h_sync
    global h_bp
    global y_res
    global v_fp
    global v_sync
    global v_bp
    global freq
    global pixel_clock
    global cv_width
    global cv_height
    global cv_x
    global cv_y
    global o_top 
    global o_bottom
    global o_left
    global o_right
    global name
    global emu
    global system

    hdmi_timing = file.readline()
    hdmi_values = hdmi_timing.split()
    x_res = int(hdmi_values[0])
    h_fp = int(hdmi_values[2])
    h_sync = int(hdmi_values[3])
    h_bp = int(hdmi_values[4])
    y_res = int(hdmi_values[5])
    v_fp = int(hdmi_values[7])
    v_sync = int(hdmi_values[8])
    v_bp = int(hdmi_values[9])
    # should be float?
    freq = float(hdmi_values[13])
    pixel_clock = float(hdmi_values[15])

    print (str(len(hdmi_values)))
    print (hdmi_values)


    print ("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
        
    if len(hdmi_values) > 17:
        cv_values = hdmi_values[17].split("#")
        cv_width = int(cv_values[1])
        cv_x = int(cv_values[2])
        cv_height = int(cv_values[3])
        cv_y = int(cv_values[4])
    else:
        cv_width = x_res
        cv_x = 0
        cv_height = y_res
        cv_y = 0

    print (str(len(cv_values)))
    print (cv_values)

    print ("Customvideo: Size (%s, %s) Pos (%s, %s)" % (cv_width, cv_height, cv_x, cv_y))
     
    if len(cv_values) > 5:
        o_top = int(cv_values[5])
        o_bottom = int(cv_values[6])
        o_left = int(cv_values[7])
        o_right = int(cv_values[8])
    else:
        o_top=0 
        o_bottom=0
        o_left=0
        o_right=0
    print ("Overscan: top, left(%s, %s) bottom, right(%s, %s)" % (o_top, o_left, o_bottom, o_right))


    if len(hdmi_values) > 18:
        name = hdmi_values[18]
        emu = hdmi_values[19]
#        system = cv_values[11]
    else:
        name="No Name" 
        emu = ""
#        system= ""

    print ("%s - %s - %s" % (name, emu, system))


def text_print(txt, x, y, r, g, b, size = 16):
    global sc_x
    global sc_y
    global aspect_ratio

    size = int (size)
    myfont = pygame.font.SysFont("Arial", size)
    x = int (x * sc_x)
    y = int (y * sc_y)
    fontScreen = myfont.render(txt, 1, (r,g,b))
    size_x = int(fontScreen.get_width() * sc_x)
    size_y = int(fontScreen.get_height() * sc_y)
    fontScreen = pygame.transform.scale(fontScreen, (size_x, size_y))
    screen.blit(fontScreen, (x, y))

# test

def calScreenStates(pressed):

    # Approaches for monitor calibration? 
    # Change distribution for timing of one resolution?
    # -> use then for all others
    
    # Or just configure the position best for screen and 
    # compute the timing?
    # -> moving only pic with fp and bp doesnt change timing

    # idea : compute timings, result is the base resolution
    # change then center with fp and bp. Express the deviation as
    # percentage distribution
    # 320 xres, moves fp-16, bp+16, is position change of +5%

    # This is the calibration mode

    if calibrateStep == 1:
        if pressed[pygame.K_RIGHT]:
            calibrateScreen ( "increase_pHActive" )
        if pressed[pygame.K_LEFT]:
            calibrateScreen ( "decrease_pHActive" )
        if pressed[pygame.K_UP]:
            calibrateScreen ( "increase_freq" )
        if pressed[pygame.K_DOWN]:
            calibrateScreen ( "decrease_freq" )


    if calibrateStep == 2:
        if pressed[pygame.K_RIGHT]:
            calibrateScreen ( "increase_pHSyncWidth" )
        if pressed[pygame.K_LEFT]:
            calibrateScreen ( "decrease_pHSyncWidth" )
        if pressed[pygame.K_UP]:
            calibrateScreen ( "increase_pVSyncWidth" )
        if pressed[pygame.K_DOWN]:
            calibrateScreen ( "decrease_pVSyncWidth" )



    if calibrateStep == 3:
        if pressed[pygame.K_RIGHT]:
            calibrateScreen ( "right" )
        if pressed[pygame.K_LEFT]:
            calibrateScreen ( "left" )
        if pressed[pygame.K_DOWN]:
            calibrateScreen ( "down" ) 
        if pressed[pygame.K_UP]:
            calibrateScreen ( "up" )

    
    if calibrateStep == 4:
        fCalib = open ("calibration.conf", "w")
        fCalib.write ("%s;%s;%s;%s;%s" % (pHActive, pHSyncWidth, pVSyncWidth, pHPos, pVPos))
        fCalib.close()
        log ("Calibrate Step 4 - Finish")
        log ("%s;%s;%s;%s;%s" % (pHActive, pHSyncWidth, pVSyncWidth, pHPos, pVPos))
        log ("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))

        return False

    return True



def calibrateScreen(action):
    global pHActive
    global pHSyncWidth
    global pVSyncWidth
    global pHPos
    global pVPos
    global h_fp
    global h_bp
    global v_fp
    global v_bp
    global base_h_fp
    global base_v_fp
    global base_v_bp
    global freq_vert_60p
    global oneTime


    if action == "increase_pHActive":
        pHActive = round (pHActive + 0.0001 ,4) 
    if action == "decrease_pHActive":
        pHActive = round (pHActive - 0.0001, 4) 
    if action == "increase_freq":
        freq_vert_60p = freq_vert_60p + 100 
    if action == "decrease_freq":
        freq_vert_60p = freq_vert_60p - 100 

    if action == "increase_pHSyncWidth":
        pHSyncWidth = round (pHSyncWidth + 0.0001, 4)
    if action == "decrease_pHSyncWidth":
        pHSyncWidth = round (pHSyncWidth - 0.0001, 4)

    if action == "increase_pVSyncWidth":
        pVSyncWidth = round (pVSyncWidth + 0.0001, 4)

    if action == "decrease_pVSyncWidth":
        pVSyncWidth = round (pVSyncWidth - 0.0001, 4)


    # in step finetuning of center pos
    # do not compute and let user finetune 
    if not calibrateStep == 3:
        computeTimings(x_res, y_res)

    # store last computed base position
    if calibrateStep == 2:

        base_h_fp = h_fp
        base_v_fp = v_fp
        base_v_bp = v_bp
        log ("base_h_fp " + str(base_h_fp) )
        log ("base_v_bp " + str(base_v_bp) )
        log ("base_v_fp " + str(base_v_fp) )

    if calibrateStep == 3:

        if oneTime:
            base_h_fp = h_fp
            base_v_fp = v_fp
            base_v_bp = v_bp
            log ("base_h_fp " + str(base_h_fp) )
            log ("base_v_bp " + str(base_v_bp) )
            log ("base_v_fp " + str(base_v_fp) )
            oneTime = False
            

        if action == "right" and h_fp >= 0 and h_bp >= 0:
            h_fp = h_fp - 1
            h_bp = h_bp + 1

        if action == "left" and h_fp >= 0 and h_bp >= 0:
            h_fp = h_fp + 1
            h_bp = h_bp - 1

        if action == "down" and v_fp >= 0 and v_bp >= 0:
            v_fp = v_fp - 1
            v_bp = v_bp + 1

        if action == "up" and v_fp >= 0 and v_bp >= 0:
            v_fp = v_fp + 1
            v_bp = v_bp - 1

        if v_fp < 0:
            v_fp=0
            if v_bp > 0:
                v_bp = v_bp - 1

        if v_bp < 0:
            v_bp=0
            if v_fp > 0:
                v_fp = v_fp - 1

        if h_fp < 0:
            h_fp=0
            if h_bp > 0:
                h_bp = h_bp - 1

        if h_bp < 0:
            h_bp=0
            if h_fp > 0:
                h_fp = h_fp - 1

        hPos = base_h_fp - h_fp
        # backporch ausprobieren
        vPos = base_v_fp - v_fp
        
        log ("base_v_fp %s  - v_fp %s = vPos %s " % (base_v_fp, v_fp, vPos) )

        pHPos = round (hPos*100/x_res, 8)
        pVPos = round (vPos*100/y_res, 8)
        log ("hpos %s vpos %s pHPos %s pVPos %s;" % (hPos, vPos, pHPos, pVPos) )
        
    pixel_clock = computePixelClock(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)    
    setResolution(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock)
    

def move(direction):
    global h_fp
    global h_bp
    global v_fp
    global v_bp
    global h_sync
    global v_sync
    global x_res
    global y_res
    global freq

    if direction == "right" and h_fp >= 0 and h_bp >= 0:
        h_fp = h_fp - 1
        h_bp = h_bp + 1

    if direction == "left" and h_fp >= 0 and h_bp >= 0:
        h_fp = h_fp + 1
        h_bp = h_bp - 1

    if direction == "down" and v_fp >= 0 and v_bp >= 0:
        v_fp = v_fp - 1
        v_bp = v_bp + 1

    if direction == "up" and v_fp >= 0 and v_bp >= 0:
        v_fp = v_fp + 1
        v_bp = v_bp - 1

    if direction == "increase_vfp" and v_fp >= 0:
         v_fp +=1
    if direction == "increase_vbp" and v_bp >= 0:
         v_bp +=1
    if direction == "decrease_vfp" and v_fp >= 0:
         v_fp -=1
    if direction == "decrease_vbp" and v_bp >= 0:
         v_bp -=1
    if direction == "increase_hfp" and h_fp >= 0:
         h_fp +=1
    if direction == "increase_hbp" and h_bp >= 0:
         h_bp +=1
    if direction == "decrease_hfp" and h_fp >= 0:
         h_fp -=1
    if direction == "decrease_hbp" and h_bp >= 0:
         h_bp -=1

    if direction == "increase_freq":
        freq = round ((freq + 0.1), 1)

    if direction == "decrease_freq":
        freq = round ((freq - 0.1), 1)


    if direction == "increase_hsync":
        h_sync = h_sync + 1

    if direction == "decrease_hsync":
        h_sync = h_sync - 1

    if direction == "increase_vsync":
        v_sync = v_sync + 1

    if direction == "decrease_vsync":
        v_sync = v_sync - 1

    if direction == "increase_xres":
        x_res = x_res + 1

    if direction == "decrease_xres":
        x_res = x_res - 1

    if direction == "increase_yres":
        y_res = y_res + 1

    if direction == "decrease_yres":
        y_res = y_res - 1

    if v_fp < 0:
        v_fp=0
        if v_bp > 0:
            v_bp = v_bp - 1

    if v_bp < 0:
        v_bp=0
        if v_fp > 0:
            v_fp = v_fp - 1

    if v_sync < 0:
        v_sync=0

    if h_sync < 0:
        h_sync=0

    if h_fp < 0:
        h_fp=0
        if h_bp > 0:
            h_bp = h_bp - 1

    if h_bp < 0:
        h_bp=0
        if h_fp > 0:
            h_fp = h_fp - 1


    setResolution(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock)

def printCalibrate():

    if calibrateStep == 1:
        txt = ("Move Left/Right to adjust the visible width of screen")
        text_print (txt, 20, 90, fc_r, fc_g, fc_b, 16)
    if calibrateStep == 2:
        txt = ("Move Left/Right to adjust horizontal sync of screen")
        text_print (txt, 20, 90, fc_r, fc_g, fc_b, 16)      
        txt = ("Move Up/Down to adjust vertical sync of screen")
        text_print (txt, 20, 110, fc_r, fc_g, fc_b, 16)
    if calibrateStep == 3:
        txt = ("Move Left/Right to adjust horizontal position of screen")
        text_print (txt, 20, 90, fc_r, fc_g, fc_b, 16)      
        txt = ("Move Up/Down to adjust vertical position of screen")
        text_print (txt, 20, 110, fc_r, fc_g, fc_b, 16)


    txt = ("Press Start Player 1 for next step")
    text_print (txt, 20, 125, fc_r, fc_g, fc_b, 14)




def printHelp():

    txt = ("B, N, M AND +/- adjust pHAct, pHSync, pHVert timings")
    text_print (txt, 20, 120, fc_r, fc_g, fc_b, 12)

    txt = ("Arrow Keys adjust position")
    text_print (txt, 20, 130, fc_r, fc_g, fc_b, 12)

    txt = ("O AND P with Arrows set overscan")
    text_print (txt, 20, 140, fc_r, fc_g, fc_b, 12)

    txt = ("R AND +/- add/sub Refreh Rate")
    text_print (txt, 20, 150, fc_r, fc_g, fc_b, 12)

    txt = ("X AND Y +/- add/sub width and heigth active lines")
    text_print (txt, 20, 160, fc_r, fc_g, fc_b, 12)

    txt = ("1, 2, 3, 4, 5, 6 AND +/- Set H_FP, H_S, H_BP, V_FP,V_S ,V_BP")
    text_print (txt, 20, 170, fc_r, fc_g, fc_b, 12)

    txt = ("F/G plus Arrows move customvideo pos and size")
    text_print (txt, 20, 180, fc_r, fc_g, fc_b, 12)

    txt = ("K/L Show Monitor Calibration On/OFf")
    text_print (txt, 20, 190, fc_r, fc_g, fc_b, 12)

    txt = ("S Save Timings")
    text_print (txt, 20, 200, fc_r, fc_g, fc_b, 12)

    txt = ("A Change Test Picture, I Change Font Color")
    text_print (txt, 20, 210, fc_r, fc_g, fc_b, 12)

    txt = ("Q Quit")
    text_print (txt, 20, 220, fc_r, fc_g, fc_b, 12)

def computeCalibration():
    global comp_pHActive
    global comp_pHSyncWidth
    global comp_pVSyncWidth

    h_active = x_res
    v_active = y_res
    h_total = h_active + h_fp + h_sync + h_bp
    v_total = v_active + v_fp + v_sync + v_bp
    _vFreq = pixel_clock / h_total / v_total
    _hFreq = pixel_clock / h_total 

    time_hTotal = 1000000 / _hFreq
    #log ("Compute Calibration")
    #log ("hFreq is " + str(_hFreq))
    #log ("time for one column is " + str(time_hTotal) + " with h_total of " + str(h_total))
    time_hActive = time_hTotal * h_active / h_total
    _pHActive = time_hActive / time_hTotal
    #log ("time for h_active is " + str(time_hActive) + " with h_active of " + str(h_active))
    #log ("Distribution of h_active is " + str(_pHActive) )
    #log ("======================")


    time_hSync = time_hTotal * h_sync / h_total
    _pHSyncWidth = time_hSync / time_hTotal
    #log ("time for h_sync is " + str(time_hSync) + " with h_sync of " + str(h_sync))
    #log ("Distribution of h_sync is " + str(_pHSyncWidth) )
    #log ("======================")

    time_vTotal = 1000000 / _vFreq
    time_vSync = time_vTotal * v_sync / v_total
    _pVSyncWidth = time_vSync / time_vTotal
    #log ("time for v_sync is " + str(time_vSync) + " with v_sync of " + str(v_sync))
    #log ("Distribution of v_sync is " + str(_pVSyncWidth) )
    #log ("======================")

    comp_pHActive = _pHActive
    comp_pHSyncWidth = _pHSyncWidth 
    comp_pVSyncWidth = _pVSyncWidth



def computeTimings (h_active, v_active):
    global h_fp
    global h_sync
    global h_bp
    global v_fp
    global v_sync
    global v_bp
    global h_total
    global v_total


    h_total = int(round(h_active / pHActive))
    h_sync = int(round(h_total * pHSyncWidth))
    h_bp = h_sync
    h_fp = h_total - h_bp - h_sync - h_active

    # adding user finetune
    #print ("h_fp %s - h_pos %s : " % (h_fp,h_pos))
    #print ("h_bp %s + h_pos %s : " % (h_bp,h_pos))

    h_fp = h_fp - h_pos
    h_bp = h_bp + h_pos
    #print ("h_fp_new " + str(h_fp))
    #print ("h_bp_new " + str(h_bp))


    v_total = int(round(freq_vert_60p / freq))
    # freq_vert_50 todo

    v_sync = int(round(v_total * pVSyncWidth))
    v_bp = int(round((v_total - v_active - v_sync) /2 + 0.5))
    v_fp = v_total - v_bp - v_sync - v_active

    #print ("v_fp %s + v_pos %s : " % (v_fp,v_pos))
    #print ("v_bp %s - v_pos %s : " % (v_bp,v_pos))
    # adding user finetune
    v_fp = v_fp - v_pos
    v_bp = v_bp + v_pos
    
    #print ("v_fp_new " + str(v_fp))
    #print ("v_bp_new " + str(v_bp))

    
    h_total_check = h_bp + h_sync + h_active + h_fp
    v_total_check = v_bp + v_sync + v_active + v_fp

    if h_total != h_total_check:
        log ("h_total check failed " + str(h_total)+ " not equal " + str(h_total_check))

    if v_total != v_total_check:
        log ("v_total check failed " + str(v_total)+ " not equal " + str(v_total_check))
     
    if v_fp < 0:
        v_fp=0
        if v_bp > 0:
            v_bp = v_bp - 1

    if v_bp < 0:
        v_bp=0
        if v_fp > 0:
            v_fp = v_fp - 1

    if v_sync < 0:
        v_sync=0

    if h_sync < 0:
        h_sync=0

    if h_fp < 0:
        h_fp=0
        if h_bp > 0:
            h_bp = h_bp - 1

    if h_bp < 0:
        h_bp=0
        if h_fp > 0:
            h_fp = h_fp - 1




#horizontal rate
def computeHFREQ(h_active, h_fp, h_sync, h_bp, pixel_clock):
    rate = pixel_clock / (h_active + h_fp + h_sync + h_bp) / 1000
    #print ("HREQ is " + str(rate) +"khz")
    return round (rate,2)

def _computeHFREQ(h_total, pixel_clock):
    rate = pixel_clock / h_total / 1000
    #print ("HFREQ is " + str(rate) +"khz")
    return round (rate,2)

#vertical rate
def computeVFREQ(h_active, h_fp, h_sync, h_bp, v_active, v_fp, v_sync, v_bp, pixel_clock):
    rate = pixel_clock / (h_active + h_fp + h_sync + h_bp) / (v_active + v_fp + v_sync + v_bp)
    #print ("VFREQ is " + str(rate) +"hz")
    return round (rate,2)

def _computeVFREQ(h_total, v_total, pixel_clock):
    rate = pixel_clock / h_total / v_total
    #print ("VFREQ is " + str(rate) +"hz")
    return round (rate,2)



def computePixelClock(h_active, h_fp, h_sync, h_bp, v_active, v_fp, v_sync, v_bp, refresh):
    #print ("compute pixel clock")
    #Usable Pixel clock are :
    #4800000 - 6400000 - 9600000 - 19200000 and > 38400000
    _pixel_clock = round ((h_active + h_fp + h_sync + h_bp) * (v_active + v_fp + v_sync + v_bp) * refresh, 0)
    #print ("pixel clock is " + str(_pixel_freq))
    if (_pixel_clock < free_pixel_clock):
        if (_pixel_clock < 5600000):
            _pixel_clock = 4800000
        else:
            if (_pixel_clock < 8000000):
                _pixel_clock = 6400000
            else:
                if (_pixel_clock < 14400000):
                    _pixel_clock = 9600000
                else:
                    _pixel_clock = 19200000       

    return _pixel_clock

def computeRealPixelClock(h_active, h_fp, h_sync, h_bp, v_active, v_fp, v_sync, v_bp, refresh):
    #print ("compute real pixel clock")
    _pixel_freq = round ((h_active + h_fp + h_sync + h_bp) * (v_active + v_fp + v_sync + v_bp) * refresh, 0)

    return _pixel_freq

def _computePixelClock(h_total, v_total, refresh):
    #print ("compute pixel clock")
    #Usable Pixel clock are :
    #4800000 - 6400000 - 9600000 - 19200000 and > 38400000
    _pixel_clock = round (h_total * v_total * refresh, 0)
    #print ("pixel clock is " + str(_pixel_clock))
    
    if (_pixel_clock < free_pixel_clock):
        if (_pixel_clock < 5600000):
            _pixel_clock = 4800000
        else:
            if (_pixel_clock < 8000000):
                _pixel_clock = 6400000
            else:
                if (_pixel_clock < 14400000):
                    _pixel_clock = 9600000
                else:
                    _pixel_clock = 19200000       
 
    
    return _pixel_clock

def setDefaultResolution():
    if debug == False:
        os.system("/opt/vc/bin/vcgencmd hdmi_timings 320 1 12 22 52 240 1 5 7 11 0 0 0 60 0 6400000 1")
        os.system("tvservice -e  \"DMT 87\" > /dev/null")
        os.popen("sleep 0.3") 
        os.popen("fbset -depth 8 && fbset -depth 24 -xres 320 -yres 240")
        os.popen("sleep 0.3") 

    else:
        print("default resolution.")

def setCustomVideo (direction):
    global cv_width
    global cv_height
    global cv_x
    global cv_y


    if direction == "cv_up":
        cv_y -= 1 
    if direction == "cv_down":
        cv_y += 1 
    if direction == "cv_right":
        cv_x += 1 
    if direction == "cv_left":
        cv_x -= 1 
    if direction == "cv_y_plus":
        cv_height += 1 
    if direction == "cv_y_minus":
        cv_height -= 1 
    if direction == "cv_x_plus":
        cv_width += 1 
    if direction == "cv_x_minus":
        cv_width -= 1 

def getOverscan ():
    global o_top 
    global o_bottom
    global o_left
    global o_right
    os.system("./overscan > overscan.cfg")
    file = open ("overscan.cfg", "r")
    overscan_line = file.readline()
    overscan_values = overscan_line.split()
    o_top = int(overscan_values[0])
    o_bottom = int(overscan_values[1])
    o_left = int(overscan_values[2])
    o_right = int(overscan_values[3])




def setOverscan (direction):
    global o_top 
    global o_bottom
    global o_left
    global o_right

    if direction == "increase_o_top":
        o_top +=1
    if direction == "decrease_o_top":
        o_top -=1
    if direction == "increase_o_left":
        o_left +=1
    if direction == "decrease_o_left":
        o_left -=1
    if direction == "increase_o_bottom":
        o_bottom +=1
    if direction == "decrease_o_bottom":
        o_bottom -=1
    if direction == "increase_o_right":
        o_right +=1
    if direction == "decrease_o_right":
        o_right -=1

    os.system("./overscan %s %s %s %s" % (o_top, o_bottom, o_left, o_right))

def setResolution(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock):

    #print("setResolution")
    if debug == True:
        pass
        #os.popen("sleep 0") 
        #print("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
        #print("tvservice -e \"DMT 87\"")
        #print("fbset -depth 8 && fbset -depth 24 -xres " + str(x_res) + " -yres " + str(y_res))
    else:
        #os.popen("/opt/vc/bin/vcgencmd hdmi_timings 320 1 12 22 52 240 1 5 7 11 0 0 0 60 0 6400000 1")

        os.popen("/opt/vc/bin/vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
        #log("vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))

        os.popen("tvservice -e \"DMT 87\"")
        os.popen("sleep 0.3") 

        os.popen("fbset -depth 8 && fbset -depth 24")

        #os.popen("fbset -depth 8 && fbset -depth 16 -xres " + str(x_res) + " -yres " + str(y_res))
        #os.popen("fbset -g 320 240 320 240 24")
        #os.popen("fbset -depth 8 && fbset -depth 16 -xres " + str(x_res) + " -yres " + str(y_res))

        os.popen("sleep 0.3") 



# run the main function only if this module is executed as the main script
# (if you import this as a module then nothing is executed)
if __name__=="__main__":
    # call the main function
    main()
