from mfrc522 import SimpleMFRC522
import configparser
import os

config_file = os.path.join(os.path.dirname(__file__), 'config.ini')
config = configparser.ConfigParser()
config.read(config_file, encoding='UTF-8')

tagId = str()


while True:
    f = open("tag.ids", "a+")
    tagId, text = reader.read()
    time.sleep(config['TIMING']['gap_elapsed_time'])
    f.write(str(tagId))
    f.close()

