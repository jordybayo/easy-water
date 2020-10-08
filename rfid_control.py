from SimpleMFRC522 import SimpleMFRC522

sp = SimpleMFRC522()

def read_tag():
    print(sp.read())
    return sp.read()

def verify_id_before_write(oldTagId):
    closeTagId = sp.read_id()
    if str(oldTagId) == str(closeTagId):
        return True

def write_tag(tagId, text):
	sp.write(text)


if __name__=='__main__':
    id = read_tag()
    if verify_id_before_write(id):
	write_tag(id, "180")
