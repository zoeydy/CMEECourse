""" This is a script showing how to use os to get the names of subdirectories and files started with specific letter"""

import subprocess
import os
import sys


"""define main function"""
def main(argv):

    # Use the subprocess.os module to get a list of files and directories 
    # in your ubuntu home directory 

    # Hint: look in subprocess.os and/or subprocess.os.path and/or 
    # subprocess.os.walk for helpful functions


    #################################
    #~Get a list of files and 
    #~directories in your home/ that start with an uppercase 'C'

    # Type your code here:
    # Get the user's home directory.
    home = subprocess.os.path.expanduser("~")
    # Create a list to store the results.
    FilesDirsStartingWithC = []
    # Use a for loop to walk through the home directory.
    for (dirs, subdirs, files) in subprocess.os.walk(home):
        FilesDirsStartingWithC += [subdir for subdir in subdirs if subdir.startswith("C")]
        FilesDirsStartingWithC += [file for file in files if file.startswith("C")]
        # for subdir in subdirs:
        #     if subdir[0] == 'C':
        #         FilesDirsStartingWithC.append(subdir)
        # for file in files:
        #     if files[0] == 'C':
        #         FilesDirsStartingWithC.append(file)
        print(FilesDirsStartingWithC)
        



    #################################
    # Get files and directories in your home/ that start with either an 
    # upper or lower case 'C'


    # Type your code here:
    home = subprocess.os.path.expanduser("~")
    FilesDirsStartingWithCc = []
    for (dirs, subdirs, files) in subprocess.os.walk(home):

        # for subdir in subdirs:
        #     if subdir.lower().startswith("c"):
        #         FilesDirsStartingWithCc.append(subdir)

        # for f in files:
        #     if f.lower().startswith("c"):
        #         FilesDirsStartingWithCc.append(f)

        FilesDirsStartingWithCc += [subdir for subdir in subdirs if subdir.lower().startswith("c")]
        FilesDirsStartingWithCc += [f for f in files if f.lower().startswith("c")]
        print(FilesDirsStartingWithCc)




    #################################
    # Get only directories in your home/ that start with either an upper or 
    #~lower case 'C' 

    # Type your code here:
    home = subprocess.os.path.expanduser("~")
    DirsStartingWithCc = []
    for (dirs, subdirs, files) in subprocess.os.walk(home):
        DirsStartingWithCc += [subdir for subdir in subdirs if subdir.lower().startswith("c")]
        print(DirsStartingWithCc)



if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
