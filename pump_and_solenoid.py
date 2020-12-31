import RPi.GPIO as GPIO

# PIN connected to IN1
relay_pin_pump = 16
relay_pin_sol = 20
relay_pin_flowmetter_out = 21


def setup():
    # Set mode BCM
    # GPIO.setmode(GPIO.BCM)
    # Type of PIN - output
    GPIO.setup(relay_pin_sol, GPIO.OUT)
    GPIO.setup(relay_pin_pump, GPIO.OUT)
    GPIO.setup(relay_pin_flowmetter_out, GPIO.OUT)

    GPIO.output(relay_pin_flowmetter_out, GPIO.HIGH)
    GPIO.output(relay_pin_sol, GPIO.HIGH)
    GPIO.output(relay_pin_pump, GPIO.HIGH)


def switch_on_sole_pump():
    try:
        # set low
        print("Setting low - SYSTEM ON")
        GPIO.output(relay_pin_flowmetter_out, GPIO.LOW)
        GPIO.output(relay_pin_sol, GPIO.LOW)
        GPIO.output(relay_pin_pump, GPIO.LOW)
    except KeyboardInterrupt:
        GPIO.cleanup()
        print("Bye")
            

def switch_off_sole_pump():
    try:
        # set high
        print("Setting high - SYSTEM OFF")
        GPIO.output(relay_pin_flowmetter_out, GPIO.HIGH)
        GPIO.output(relay_pin_sol, GPIO.HIGH)
        GPIO.output(relay_pin_pump, GPIO.HIGH)
    except KeyboardInterrupt:
        GPIO.cleanup()
        print("Bye")


def line_cleanup():
    # clean all GPIO pins of the module
    GPIO.cleanup(relay_pin_flowmetter_out)
    GPIO.cleanup(relay_pin_sol)
    GPIO.cleanup(relay_pin_pump)
            

if __name__ == "__main__":
    setup()
    switch_off_sole_pump()
    line_cleanup()
