import os
import sys

#debug = True
debug = False

#pHActive = 0.77
#pHSyncWidth = 0.092
#pVSyncWidth = 0.03
pHActive = 0.745
pHSyncWidth = 0.117
pVSyncWidth = 0.03

pHPos = 0
pVPos = 0
h_pos = 0
v_pos = 0


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
rotation = 0

# overscan
o_top=0 
o_bottom=0
o_left=0
o_right=0

#free_pixel_clock = 38400000
free_pixel_clock = 31270000

log_file = open ("log_compute_res_cmd.txt", "a")


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
    global rotation
    
    if len(sys.argv) > 1:
        x_res = int(sys.argv[1])    
        y_res = int(sys.argv[2])    
        freq = float(sys.argv[3])
        rotation = int(sys.argv[4])

        read_calibration_conf()

        # Unterscheidung horizontal screen with 
        # vertical games
        #assuming on horizontal screens!
        #if vertical == 1:	
        #    x_res = int(sys.argv[2])    
        #    #y_res = int(sys.argv[1])    
        #    # pacman downscale von 288 auf 270
        #    y_res = 270    
        #    print("vertical" + str(y_res))
            

        #poverscan = int(sys.argv[4])
        #cv_width = int(sys.argv[4])
        #cv_heigth = int(sys.argv[5])
        #cv_x = int(sys.argv[6])
        #cv_y = int(sys.argv[7])
 
    else:
        print ("not valid")
        quit()

        

    computeTimings(x_res, y_res)

    pixel_clock = computePixelClock(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)
    
    getSuperResolution ()

    if debug:
        print ("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))


    log ("%s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))

    cv_width = round (x_res - x_res * poverscan / 100)
    cv_height = round (y_res - y_res * poverscan / 100)
    #cv_height = 228

    cv_x = round ((x_res - cv_width) / 2)
    cv_y = round ((y_res - cv_height) / 2)

    _h_rate = computeHFREQ(x_res, h_fp, h_sync, h_bp, pixel_clock)
    _v_rate = computeVFREQ(x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, pixel_clock)

    #getOverscan()

    saveRetroarchConfig()
    setResolution (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock)


def log(msg):
    log_file.write(msg)
    log_file.write("\n")

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

    if len(hdmi_values) > 18:
        name = hdmi_values[18]
        emu = hdmi_values[19]
#        system = cv_values[11]
    else:
        name="No Name" 
        emu = ""
#        system= ""

def getSuperResolution():

    global x_res
    global pixel_clock

    fac_ctr = 1
    x_res_pump = x_res
    computeTimings (x_res_pump, y_res)

    _clock = computeRealPixelClock(x_res_pump, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)

    #log ("x_res_pump " + str (x_res_pump))
    #log ("pclk " + str (_clock))

    
    while _clock < free_pixel_clock:
        fac_ctr = round(fac_ctr + 0.1, 1) 
        x_res_pump = round (x_res * fac_ctr)
        computeTimings (x_res_pump, y_res)
        _clock = computePixelClock(x_res_pump, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq)

    x_res = x_res_pump
    pixel_clock = _clock
    log ("factor " + str (fac_ctr))
    log ("x_res_pump " + str (x_res_pump))
    log ("pclk " + str (_clock))


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
    #log ("h_fp %s - h_pos %s : " % (h_fp,h_pos))
    #log ("h_bp %s + h_pos %s : " % (h_bp,h_pos))

    h_fp = h_fp - h_pos
    h_bp = h_bp + h_pos
    #log ("h_fp_new " + str(h_fp))
    #log ("h_bp_new " + str(h_bp))


    v_total = int(round(freq_vert_60p / freq))
    # freq_vert_50 todo

    v_sync = int(round(v_total * pVSyncWidth))
    v_bp = int(round((v_total - v_active - v_sync) /2 + 0.5))
    v_fp = v_total - v_bp - v_sync - v_active

    #log ("v_fp %s + v_pos %s : " % (v_fp,v_pos))
    #log ("v_bp %s - v_pos %s : " % (v_bp,v_pos))
    # adding user finetune
    v_fp = v_fp - v_pos
    v_bp = v_bp + v_pos
    
    #log ("v_fp_new " + str(v_fp))
    #log ("v_bp_new " + str(v_bp))

    
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




def _computeTimings (h_active, v_active):
    global h_fp
    global h_sync
    global h_bp
    global v_fp
    global v_sync
    global v_bp
    global h_total
    global v_total

    # adding user finetune
    h_pos = round (x_res * pHPos / 100)
    v_pos = round (y_res * pVPos / 100)
    
    h_total = int(round(h_active / pHActive))
    h_sync = int(round(h_total * pHSyncWidth))
    h_bp = h_sync
    h_fp = h_total - h_bp - h_sync - h_active

    # adding user finetune
    h_fp = h_fp + h_pos
    h_bp = h_bp - h_pos

    v_total = int(round(freq_vert_60p / freq))
    # freq_vert_50 todo

    v_sync = int(round(v_total * pVSyncWidth)) -2 
    v_bp = int(round((v_total - v_active - v_sync) /2 + 0.5)) +3
    v_fp = v_total - v_bp - v_sync - v_active -3

    # adding user finetune
    v_fp = v_fp + v_pos
    v_bp = v_bp - v_pos


    
    h_total_check = h_bp + h_sync + h_active + h_fp
    v_total_check = v_bp + v_sync + v_active + v_fp

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
        log("default resolution.")

def saveRetroarchConfig ():

#    file = open ("/root/.config/retroarch/game.cfg", "w")
    file = open ("game.cfg", "w")
    file.write("custom_viewport_width = \"%s\"\n" % (cv_width))
    file.write("custom_viewport_height = \"%s\"\n" % (cv_height))
    file.write("custom_viewport_x = \"%s\"\n" % (cv_x))
    file.write("custom_viewport_y = \"%s\"\n" % (cv_y))

    file.write("video_scale_integer = \"false\"\n")
    file.write("aspect_ratio_index = \"22\"\n")
    file.write("video_smooth = \"false\"\n")
    file.write("video_threaded = \"false\"\n")
    file.write("crop_overscan = \"false\"\n")
    
    file.write("video_rotation = \"%s\"\n" % (rotation))
   
    # vertical games on h screen 
    #file.write("video_rotation = \"0\"\n")

    file.close()

    

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

def setOverscan ():
    global o_top 
    global o_bottom
    global o_left
    global o_right

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
        os.popen("/opt/vc/bin/vcgencmd hdmi_timings %s 1 %s %s %s %s 1 %s %s %s 0 0 0 %s 0 %s 1" % (x_res, h_fp, h_sync, h_bp, y_res, v_fp, v_sync, v_bp, freq, pixel_clock))
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
