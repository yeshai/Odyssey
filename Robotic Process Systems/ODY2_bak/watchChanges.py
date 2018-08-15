import csv
import datetime
import os
import time
import difflib
from sys import exit
from shutil import copyfile
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

path = 'C:/ProgramData/Robotic Process Systems/MaestroLite 4/'
writeFile = 'Odyssey2_Log.csv'
readFile = 'UserVars.dat'

readFile2 = 'UserVars(2).dat'

source = path + readFile
target = path + readFile2

def datFileToDict(path,readFile):  #function outputs an associative array for the Odyssey UserVars.dat file
    timestamp = {'timestamp': '{:%Y-%b-%d %H:%M:%S}'.format(datetime.datetime.now())}
    readFilePath = path + readFile
    with open(readFilePath, "r") as ins: #open in read mode
        lineArray = [] #an array with each element will be a line from UserVars.dat
        for line in ins:
            lineArray.append(line.rstrip('\n')) #put each into an array
    keys = []
    for j in range(7, 32,4): #range(start,stop,step)
        key = lineArray[j].split("=")
        key.pop(0)
        keys.extend(key)
    values = []
    for k in range(86,93):
        value = lineArray[k].split(";")
        value.pop(0)
        values.extend(value)
    jobParameters = dict(zip(keys, values))
    jobParameters.update(timestamp)
    return jobParameters

def csvToDict (path,writeFile):
    writeFilePath = path + writeFile
    if os.path.getsize(writeFilePath) !=0:
        with open(writeFilePath, 'rb') as csvfile:
            reader = csv.reader(csvfile, delimiter=",")
            lastRow = (','.join(reversed(list(csv.reader(csvfile))[-1]))).split(',')
            lastRow.sort()
            return lastRow
            csvfile.close

def dictToCsv(path, writeFile, jobParameters): #function pushes a dict to a csv file
    writeFilePath = path + writeFile
    with open(writeFilePath, 'rb') as csvfile:
        checkFile =  os.path.getsize(writeFilePath)  # check file size
        csvfile.close
    fieldnames = jobParameters.keys()
    with open(writeFilePath, 'ab') as csvfile:
        writer = csv.writer(csvfile,dialect='excel')
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        if checkFile == 0:
            writer.writeheader()
        writer.writerow(jobParameters)
        csvfile.close
    return None

def compareTwoFiles(text1, text2):
    # Open file for reading in text mode (default mode)
    f1 = open(text1)
    f2 = open(text2)
    different = False

    # Read the first line from the files
    f1_line = f1.readline()
    f2_line = f2.readline()

    # Initialize counter for line number
    line_no = 1

    # Loop if either file1 or file2 has not reached EOF
    while f1_line != '' or f2_line != '':

        # Strip the leading whitespaces
        f1_line = f1_line.rstrip()
        f2_line = f2_line.rstrip()

        # Compare the lines from both file
        if f1_line != f2_line:

            # If a line does not exist on file2
            if f2_line == '' and f1_line != '':
                different = True
                #print('change!')
            # otherwise output the line on file1
            elif f1_line != '':
                different = True
                #print('change!')
            # If a line does not exist on file1
            if f1_line == '' and f2_line != '':
                different == True
                #print('change!')

            # otherwise output the line on file2
            elif f2_line != '':
                different = True
                #print('change!')

        # Read the next line from the file
        f1_line = f1.readline()
        f2_line = f2.readline()

        # Increment line counter
        line_no += 1

    # Close the files
    f1.close()
    f2.close()
    return(different)

#compareTwoFiles(readFile, readFile2)

class MyHandler(FileSystemEventHandler):

    def on_modified(self, event):
        different = compareTwoFiles(readFile, readFile2)
        if different == True:
            print('DIFFERENT!')
            # copy file
            try:
                copyfile(source, target)
            except IOError as e:
                print("Unable to copy file. %s" % e)
                exit(1)
            except:
                print("Unexpected error:", sys.exc_info())
                exit(1)
            print("\nFile copy done!\n")
            jobParameters = datFileToDict(path, readFile)
            currentRow = jobParameters
            #del currentRow['timestamp']
            currentRow = currentRow.values()
            currentRow.sort()
            lastRow = csvToDict(path, writeFile)
            if cmp(currentRow,lastRow)!=0:
                print ('change detected')
                dictToCsv(path, writeFile, jobParameters)


if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path=path, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(10)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
