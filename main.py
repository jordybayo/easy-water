import flow_metter_control
import time
import os
from multiprocessing import Process
from factory import FileFactory

print("===================1================")
import RPi.GPIO as GPIO
GPIO.setwarnings(False)
flow_metter_control.setup()

on = False
newTagObject = dict()
oldTagObject = dict()
gapElapsedTime = 2.2
cloudWateQuantity = 18
minValueToHaveToFectchWater = 1
pulseFlow = 0
factory = FileFactory("tag.csv", "tag.ids")


def haltOnWaterFlowing():
    """verify rapidly if there is water flowing for a specific tag, if so 
        close rapidly if it has reached the total tag flow value"""
    global on 
    if on == True:
        if cloudWateQuantity <= pulseFlow:
            count, pulseFlow = flow_metter_control.stop_flow_counter()
            on = False
            flow_metter_control.resetCountAndFlow() # set to 0 count and flow
            print("::::::::::::: the flow is ", pulseFlow)
            # TODO: save flow and count on firebase

def tree_exec():
    if factoy.len(True) < factory.len(False):
        oldTagObject = factory.readFileLastLine(True)
        newTagObject = factory.readFileLastLine(False)
        if oldTagObject['action'] == 'on':
            if (oldTagObject['id'] == newTagObject['id']):
                count, pulseFlow = flow_metter_control.stop_flow_counter()
                on = False
                flow_metter_control.resetCountAndFlow() # set to 0 count and flow
                print("::::::::::::: the flow is ", pulseFlow)
                # TODO: save flow and count on firebase

        elif oldTagObject['action'] == 'off':
            # TODO: get the water value of the card from firebase using his tagId
            cloudWateQuantity = 15 # i simmulate the fact that we already have the value
            if cloudWateQuantity >= minValueToHaveToFectchWater:
                factory.append_csv(newTagObject) # save to the csv doc, the new tagObject
                on = True
                flow_metter_control.start_flow_counter2()
            else:
                # TODO: show on screen that use dont have enought water flow to open tap
                print("You dont have enought water flow")



def runInParallel(*fns):
  proc = []
  for fn in fns:
    p = Process(target=fn)
    p.start()
    proc.append(p)
  for p in proc:
    p.join()


while True:
    runInParallel(haltOnWaterFlowing, tree_exec)