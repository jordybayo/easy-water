import csv as CSV
class FileFactory(object):

    def __init__(self, csv_file: str, ids_file: str):
        self.csv_file = csv_file
        self.ids_file = ids_file
    
    def readFileLastLine(self, csv: bool):
        if csv is True:
            raw = str()
            with open(self.csv_file) as f:
                raw = str(f.readlines()[-1])  # .replace("\n", "")
                raw = raw.split(",")
                raw = {"id": raw[0], "action": raw[1]}
            return raw
        else:
            with open(self.ids_file, "r") as f1:
                
                try:
                    last_line = f1.readlines()[-1]
                    return str(last_line)  # return the parsed string to dict of the value
                except IndexError as identifier:
                    print(identifier)  # debug show
                    return None
    
    def len(self, csv: bool):
        if csv is True:
            file = open(self.csv_file)
            reader = CSV.reader(file)
            lines = len(list(reader))
            file.close()
            return lines
        else:
            file = open(self.ids_file, "r")
            nonempty_lines = [line.strip("\n") for line in file if line != "\n"] # line.strip("\n") 
            # removes "\n"
            lines = len(nonempty_lines)
            file.close()
            return lines

    def append_csv(self, value: dict):
        with open(self.csv_file, 'a+') as f_object:
            # Pass this file object to csv.writer() 
            # and get a writer object
            writer_object = CSV.writer(f_object)
            # Pass the list as an argument into 
            # the writerow() 
            writer_object.writerow([value["id"], value["action"]])
            f_object.close()

    def format_dict(self, tagId: str, action: str) -> dict:
        return {'id': tagId, 'action': action}


def get_csv_test():
    c = FileFactory(csv_file="tag.csv", ids_file="tag.ids")
    diction = c.readFileLastLine(csv=True)
    print(diction, type(diction))
    print(diction['action'])


def get_file_test():
    c = FileFactory(csv_file="tag.csv", ids_file="tag.ids")
    diction = c.readFileLastLine(csv=False)
    print(diction, type(diction))


def testWrite():
    c = FileFactory(csv_file="tag.csv", ids_file="tag.ids")
    Dict = {'id': 'sdöfjsdfk', 'action': 'on'}
    c.append_csv(value=Dict)



