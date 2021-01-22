from local_mfrc522 import SimpleMFRC522

reader = SimpleMFRC522()

while True:
    try:
        tagId, text = reader.read()
        print("TAG IFD IS : ", tagId)
        break
    except:
        print("===error writing while getting card===")
        break
    

