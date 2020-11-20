""" This is blah blah"""

import subprocess
import os


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
    dirs = dirs.split() # ? dirs(string -> list); while lists is list
    for dir in dirs:
        if dir[0] == 'C':
            FilesDirsStartingWithC.append(dir)
    for subdir in subdirs:
        if subdir[0] == 'C':
            FilesDirsStartingWithC.append(subdir)
    for file in files:
        if files[0] == 'C':
            FilesDirsStartingWithC.append(file)

# print(FilesDirsStartingWithC)
    



#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'


# Type your code here:
home = subprocess.os.path.expanduser("~")
FilesDirsStartingWithCc = []
for (dirs, subdirs, files) in subprocess.os.walk(home):
    dirs = dirs.split()

    for dir in dirs:
        if dir[0] == 'C':
            FilesDirsStartingWithCc.append(dir)
        if dir[0] == 'c':
            FilesDirsStartingWithCc.append(dir)

# print(FilesDirsStartingWithCc)




#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
home = subprocess.os.path.expanduser("~")
FilesDirsStartingWithC = []



############ outline

# 1. get directory
# 2. set a blank list to store the data
# 3. get the directorys, subdirectories and files name
# 4. check the first letter of the names using if statement
    # for the 2nd question, I tried to do like 
    # '''cap_words = [word.capitalize for word in words]'''
    # but after that using if statement I will get error 
    # '''TypeError: 'builtin_function_or_method' object is not subscriptable'''

# 5. append the data
## do not so clear about the last question means