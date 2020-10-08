
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import os
import configparser

config_file = os.path.join(os.path.dirname(__file__), 'config.ini')
config = configparser.ConfigParser()
config.read(config_file, encoding='UTF-8')

# Fetch the service account key JSON file contents
cred = credentials.Certificate('easywater-ab61b-firebase-adminsdk-pedxo-ab3626c9ae.json')

# Initialize the app with a custom auth variable, limiting the server's access
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://easywater-ab61b.firebaseio.com/',
    'databaseAuthVariableOverride': {
        'uid': config['ACCESS']['RPI_UID']
    }
})

def save_tag_ops(tagId, openTime, closeTime, waterValue):
    ref = db.reference('tags_history')
    tag_ref = ref.child(str(tagId))
    tag_ref.set({
        'chip': tagId,
        'open': openTime,
        'close': closeTime,
        'water_value': waterValue,
    })

def upload_new_secret_key():
    ref = db.reference('/chips')
    data = ref.get()
    # set the new secret key
    config['ACCESS']['SECRET_KEY'] = data['rpi1_100920202245']
    with open('config.ini', 'w') as configfile:
        config.write(configfile)
        return True

# activity type 1-request|write-2|load-3
# problem level - 1-low|2-basic|3-medium|4-alert|5-warning|6-crash
# concern - sensor name
# descriptiom
# activity type - normalActivity|problem|
def monitor_analytics(chipId, timestamp, activityType, sensorConcerned, description, begin:Bool, Ended:Bool):
    """Store all type operation when running and after runing

    Args:
        chipId ([String]): [the chip that send the monitoring data]
        timestamp ([timestamp]): [time shot when happenned]
        activityType ([int]): [descibe the type of operation 1-request|write-2|load-3]
        sensorConcerned ([String]): [Id of the concerned thing if(if possible) + string name ]
        description ([String]): [String description]
        begin:(Bool) Indicate if an operation has successfully or not start
        Ended:Bool: Indicate if an operation has successfully or not completed
    """
    analytics_ref= db.reference('analytcis')
    analytics_ref.update({
        '{}:{}'.format(chipId, timestamp) : '{}:{}:{}'.format(activityType, sensorConcerned, description)
    })


if __name__ == '__main__':
    save_tag_ops('rpi1_100920202245', 1600171297.057834, 1600171325.236106, 18)
