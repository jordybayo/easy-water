import flow_metter_control
from multiprocessing import Process
from factory import FileFactory
import RPi.GPIO as GPIO
import time

from service import TagFlow

GPIO.setwarnings(False)
flow_metter_control.setup()

on = False
newTagObject = dict()
oldTagObject = dict()
cloudWateQuantity = 0
minValueToHaveToFectchWater = 1
pulseFlow = 0
count = 0
factory = FileFactory("tag.csv", "tag.ids")


def haltOnWaterFlowing():
    """verify rapidly if there is water flowing for a specific tag, if so 
        close rapidly if it has reached the total tag flow value"""
    global on
    global pulseFlow
    global cloudWateQuantity
    if on is True:
        if float(pulseFlow) >= float(cloudWateQuantity):
            count, pulseFlow = flow_metter_control.stop_flow_counter()
            on = False
            flow_metter_control.resetCountAndFlow()  # set to 0 count and flow
            print("::::::::::::: the count is: {} and pulseFlow is: {}".format(pulseFlow, count))
            newTagObject = factory.readFileLastLine(False)
            factory.append_csv(factory.format_dict(tagId=newTagObject, action="off"))  # save to the csv doc, the
            service = TagFlow(newTagObject)
            service.update(0)  # set water value to zero considering that water flow is finish


def tree_exec():

    global on
    global count
    global pulseFlow
    global cloudWateQuantity
    if factory.len(True) < factory.len(False):
        oldTagObject = factory.readFileLastLine(csv=True)
        newTagObject = factory.readFileLastLine(csv=False)

        if "on" in oldTagObject['action']:
            if (oldTagObject['id'] == newTagObject):
                count, pulseFlow = flow_metter_control.stop_flow_counter()
                on = False
                flow_metter_control.resetCountAndFlow()  # set to 0 count
                # and  flow
                print("::::::::::::: the count is: {} and pulseFlow is: {}".format(pulseFlow, count))
                factory.append_csv(factory.format_dict(tagId=newTagObject, action="off"))  # save to the csv doc, the
                service = TagFlow(newTagObject)
                prev_water_flow = service.get()
                # save in firestore the prev water flow minus the consumed water flow
                cloudWateQuantity = service.update(prev_water_flow - count)

        elif "off" in oldTagObject['action']:
            service = TagFlow(newTagObject)
            try:
                cloudWateQuantity = service.get()  # get tag flow from firestore
                if cloudWateQuantity is not None:
                    #TODO: show on screen that our system do not recognize the card
                    if float(cloudWateQuantity) >= minValueToHaveToFectchWater:
                        factory.append_csv(factory.format_dict(tagId=newTagObject, action="on"))  # save to the csv doc, the
                        # new tagObject
                        on = True
                        flow_metter_control.start_flow_counter2()
                        print("::::::::::::: water flowing")
                    else:
                        # TODO: show on screen that use dont have enought water flow
                        # to open tap
                        print("You dont have enought water flow")
            finally:
                print("could not recognize your tag, or problem gettings your card")


def runInParallel(*fns):
    proc = []
    for fn in fns:
        p = Process(target=fn)
        p.start()
        proc.append(p)
    for p in proc:
        p.join()


while True:
    runInParallel(haltOnWaterFlowing(), tree_exec())
    oldTagObject = dict()
    # time.sleep(1)
    print("///////////////////////////////// the count is: {} and pulseFlow is: {}".format(pulseFlow, count))
