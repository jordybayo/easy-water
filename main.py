import flow_metter_control
from multiprocessing import Process
from factory import FileFactory
import RPi.GPIO as GPIO
import time

print("===================1================")
GPIO.setwarnings(False)
flow_metter_control.setup()

on = False
newTagObject = dict()
oldTagObject = dict()
cloudWateQuantity = 15
minValueToHaveToFectchWater = 1
pulseFlow = 0
factory = FileFactory("tag.csv", "tag.ids")

print("===================2================")


def haltOnWaterFlowing():
    """verify rapidly if there is water flowing for a specific tag, if so 
        close rapidly if it has reached the total tag flow value"""
    global on
    global pulseFlow
    global cloudWateQuantity
    print("===================3================")
    if on is True:
        print("===================4================")
        if pulseFlow >= cloudWateQuantity:
            print("===================44================")
            count, pulseFlow = flow_metter_control.stop_flow_counter()
            on = False
            print("::::::::::::: the flow is stpped")
            flow_metter_control.resetCountAndFlow()  # set to 0 count and flow
            print("::::::::::::: the flow is ", pulseFlow)
            newTagObject = factory.readFileLastLine(False)
            factory.append_csv(factory.format_dict(tagId=newTagObject, action="off"))  # save to the csv doc, the
            # TODO: save flow and count on firebase
        print("===================5================")


def tree_exec():

    global on
    global pulseFlow
    global cloudWateQuantity
    print("===================6================")
    if factory.len(True) < factory.len(False):
        oldTagObject = factory.readFileLastLine(csv=True)
        print("***********oldTagObject: ***********", oldTagObject)
        newTagObject = factory.readFileLastLine(csv=False)
        if oldTagObject['action'] == 'on':
            print("===================7================")
            if (oldTagObject['id'] == newTagObject):
                print("===================8================")
                count, pulseFlow = flow_metter_control.stop_flow_counter()
                print("::::::::::::: water stop flowing")
                on = False
                flow_metter_control.resetCountAndFlow()  # set to 0 count
                # and  flow
                print("::::::::::::: the flow is ", pulseFlow)
                factory.append_csv(factory.format_dict(tagId=newTagObject, action="off"))  # save to the csv doc, the
                # TODO: save flow and count on firebase
                print("===================9================")

        elif oldTagObject['action'] == 'off':
            print("===================10================")
            # TODO: get the water value of the card from firebase using his
            #  tagId the value
            if cloudWateQuantity >= minValueToHaveToFectchWater:
                print("===================11================")
                factory.append_csv(factory.format_dict(tagId=newTagObject, action="on"))  # save to the csv doc, the
                # new tagObject
                on = True
                flow_metter_control.start_flow_counter2()
                print("::::::::::::: water flowing")
            else:
                print("===================12================")
                # TODO: show on screen that use dont have enought water flow
                # to open tap
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
    print("===================0================")
    runInParallel(haltOnWaterFlowing(), tree_exec())
    oldTagObject = dict()
    # tree_exec()
    print("===================13================")
    time.sleep(4)
    pulseFlow += 1
    print("/////////////////////////////////pulse<Flow", pulseFlow)
