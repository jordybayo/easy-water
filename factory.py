import ast
import csv as CSV
import linecache 


class FileFactory(object):

    def __init__(self, csv_file: str, ids_file: str):
        self.csv_file = csv_file
        self.ids_file = ids_file
    
    def readFileLastLine(self, csv: bool):
        if csv is True:
            # cheap way to get the number of lines in a file (Not sure what the best way is. 
            # lineno = len(open(filename).readlines()) 
            with open(self.csv_file) as f: lineno = sum(1 for line in f)
            # get the last line. 
            last_row = linecache.getline(self.csv_file, lineno, module_globals=None)
            last_row = ast.literal_eval(last_row)
            return ast.literal_eval(last_row)
        else:
            with open(self.ids_file, "r") as f1:
                
                try:
                    last_line = f1.readlines()[-1]
                    return str(last_line)  # return the parsed string to dict of the value
                except IndexError as identifier:
                    print(identifier) # debug show
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
        List = list()
        List.append(value)
        with open(self.csv_file, 'a') as f_object:
            # Pass this file object to csv.writer() 
            # and get a writer object
            writer_object = CSV.writer(f_object)
            # Pass the list as an argument into 
            # the writerow() 
            writer_object.writerow(List)
            # Close the file object 
            f_object.close()

    def format_dict(self, tagId: str, action: str) -> dict:
        return {'id': tagId, 'action': action}


def test():
    c = FileFactory(csv_file="tag.csv", ids_file="tag.ids")
    diction = c.readFileLastLine(csv=True)
    print(diction, type(diction))
    print(diction['action'])


def testWrite():
    c = FileFactory(csv_file="tag.csv", ids_file="tag.ids")
    Dict = {'id':'sdöfjsdfk', 'action':'on'}
    c.append_csv(value=Dict)
