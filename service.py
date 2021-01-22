
import os, datetime
import configparser
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

config_file = os.path.join(os.path.dirname(__file__), 'config.ini')
config = configparser.ConfigParser()
config.read(config_file, encoding='UTF-8')

# Fetch the service account key JSON file contents
cred = credentials.Certificate('easywater-ab61b-firebase-adminsdk-pedxo-ab3626c9ae.json')

# Initialize the app with a custom auth variable, limiting the server's access
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://easywater-ab61b.firebaseio.com/',
})

db = firestore.client()


class TagFlow():
    """Interract with Firestore tag collection to carry out some CRUD operations
    """

    def __init__(self, card_id):
        self.doc_ref = db.collection('card_tags')
        self.rfid_nfc_corresp_ref = db.collection("rfid_nfc_correspondance")
        self.card_id = str(card_id)
        self.nfc_reader_id = self.rfid_nfc_correspondance()

    def get(self):
        tag_obj = self.doc_ref.document(self.nfc_reader_id)
        doc = tag_obj.get()
        if doc.exists:
            return doc.to_dict()["water_flow"]
        else:
            print(u'No such document!')

    def get_history(self):
        tag_obj = self.doc_ref.document(self.nfc_reader_id)
        doc = tag_obj.get()
        if doc.exists:
            return doc.to_dict()["history"]
        else:
            print(u'No such document!')

    def update(self, new_flow):
        tag_obj = self.doc_ref.document('{}'.format(self.nfc_reader_id))
        try:
            tag_obj.update({'water_flow': new_flow})
            self.add_in_history(datetime.datetime.now(), new_flow)
            return True
        except:
            return False

    def add_in_history(self, date_time, water_value):
        ref = self.doc_ref.document(self.nfc_reader_id)
        history = self.get_history()
        history.append({"fetched": "{}, {}".format(date_time, water_value)})
        ref.update({'history': history})

    def rfid_nfc_correspondance(self):
        rfid_nfc_corresp = self.rfid_nfc_corresp_ref.document(self.card_id)
        doc = rfid_nfc_corresp.get()
        if doc.exists:
            return doc.to_dict()["nfc_reader_id"]
        else:
            print(u'No such document!')


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
def monitor_analytics(chipId, timestamp, activityType, sensorConcerned, description, begin:bool, Ended:bool):
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


def main():
    a = 154995123
    t = TagFlow(a)
    # print(t.get())
    # print(t.update(54.45764567))

if __name__ == '__main__':
    # save_tag_ops('rpi1_100920202245', 1600171297.057834, 1600171325.236106, 18)
    main()