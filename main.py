import flow_metter_control
import time
import os
import signal
import sys
import  asyncio

print("===================1================")
import RPi.GPIO as GPIO
GPIO.setwarnings(False)
from mfrc522 import SimpleMFRC522
flow_metter_control.setup()

reader = SimpleMFRC522()
on = False
tagId = str()
oldTagId = ""
gapElapsedTime = 2.2
cloudWateQuantity = 0
minValueToHaveToFectchWater = 1
pulseFlow = 0



async def startByVerifiying():
    while True:
        globalVars = globals()
        globalVars['reader', 'on', 'tagId', 'oldTagId', 'gapElapsedTime', 'cloudWateQuantity', 'minValueToHaveToFectchWater', 'pulseFlow']
        tagId = ""
        print("===================2================")


        if on == True:
            print("===================3================")
            if cloudWateQuantity <= pulseFlow:
                print("===================4================")
                count, pulseFlow = flow_metter_control.stop_flow_counter()
                flow_metter_control.resetCountAndFlow() # set to 0 count and flow
                print("::::::::::::: the flow is ", pulseFlow)
                # TODO: save flow and count on firebase
                print("===================5================")

async def getCardFirst():
    while True:
        globalVars = globals()
        globalVars['reader', 'on', 'tagId', 'oldTagId', 'gapElapsedTime', 'cloudWateQuantity', 'minValueToHaveToFectchWater', 'pulseFlow']
        tagId = ""
        print("===================6================")
        tagId, text = reader.read() 
        print("===================7================")


        if tagId != "":
            time.sleep(gapElapsedTime)
            print("===================8================")
            if on == True:
                print("===================9================")
                if tagId == oldTagId:
                    print("===================10================")
                    count, pulseFlow = flow_metter_control.stop_flow_counter()
                    flow_metter_control.resetCountAndFlow() # set to 0 count and flow
                    print("::::::::::::: the flow is ", pulseFlow)
                    # TODO: save flow and count on firebase
                    print("===================11================")
            else:
                print("===================12================")
                # TODO: get the water value of the card from firebase using his tagId
                cloudWateQuantity = 15 # i simmulate the fact that we already have the value
                if cloudWateQuantity >= minValueToHaveToFectchWater:
                    print("===================13================")
                    oldTagId = tagId
                    flow_metter_control.start_flow_counter2()
                    print("===================14================")
                else:
                    print("===================15================")
                    # TODO: show on screen that use dont have enought water flow to open tap
                    print("You dont have enought water flow")
                    print("===================16================")



def signal_handler(signal, frame):
    tagId = ""
    loop.stop()
    sys.exit(0)


signal.signal(signal.SIGINT, signal_handler)

asyncio.ensure_future(startByVerifiying())
asyncio.ensure_future(getCardFirst())