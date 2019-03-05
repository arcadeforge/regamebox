import os
import sys
import time
import keyboard


# define a main function
def main():

    #os.popen("pikeyd165 -smi -ndb -d")
    #os.popen("sleep 5")
    ctr = 0
    ctr_check = 0
    running = True
    while running:
        if keyboard.is_pressed('&'):  
            ctr += 1   
    
            #print ("%s event" % (ctr))

        ctr_check += 1 
        #os.popen("sleep 0.3") 
        if ctr_check == 1000:
            if ctr > 1:
                print ("0")
            else:
                #print ("pi2scart ctr %s ctr_check %s" % (ctr, ctr_check))
                #
                print ("1")

            running = False
            
    #os.popen("pikeyd165 -k")
                   
# run the main function only if this module is 
# executed as the main script (if you import 
# this as a module then nothing is executed)
if __name__=="__main__":
    # call the main function
    main()
