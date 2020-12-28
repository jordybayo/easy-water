from mfrc522 import SimpleMFRC522
import configparser
import os
import time

reader = SimpleMFRC522()

config_file = os.path.join(os.path.dirname(__file__), 'config.ini')
config = configparser.ConfigParser()
config.read(config_file, encoding='UTF-8')


while True:
    
    try:
        f = open("tag.ids", "a+")
        tagId, text = reader.read()
        time.sleep(config['TIMING']['gap_elapsed_time'])
        f.write(str(tagId))
        f.close()
        print("====wrtite Done===")
    except:
        print("===error writing===")
    

