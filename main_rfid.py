from local_mfrc522 import SimpleMFRC522
import configparser
import os
import time

reader = SimpleMFRC522()

config_file = os.path.join(os.path.dirname(__file__), 'config.ini')
config = configparser.ConfigParser()
config.read(config_file, encoding='UTF-8')


while True:
    try:
        tagId, text = reader.read()
        # tagId = int(input()) # 154995123
        time.sleep(int(config['TIMING']['gap_elapsed_time']))
        with open('tag.ids', "a+") as f:
            f.write("\n{}".format(tagId))
            f.close()
        print("====wrtite Done===")
    except:
        print("===error writing===")
    

