
""" examples of regular expression"""

import re
import sys


"""define main function"""

def main(argv):

    my_string = "a given string"

    # find a space in the string
    match = re.search(r'\s', my_string)
    print(match)
    # to see the match
    match.group()
    # another patern
    match = re.search(r'\d', my_string)
    print(match)
    # to know whether a pattern was matched, we can use if
    MyStr = 'an example'
    match = re.search(r'\w*\s', MyStr)
    if match:
        print('found a match:', match.group())
    else:
        print('did not find a match')


    match = re.search(r'2', "it takes 2 to tango")
    match.group()

    match = re.search(r'\d', "it takes 2 to tango")
    match.group()

    match = re.search(r'\d.*', "it takes 2 to tango")
    match.group()

    match = re.search(r'\s\w{1,3}\s', 'one upon a time')
    match.group()

    match = re.search(r'\s\w*$', 'once upon a time')
    match.group()

    # by directly appending .group() to return the matched group
    re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
    re.search(r'^\w*.*\s', 'once upon a time').group() # find the numcharactor followed by whitespace
    # "*, +, {} VS. ?"
    re.search(r'^\w*.*?\s', 'once upon a time').group()

    # To further illustrate greediness in regexes, let’s try matching an HTML tag:
    re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
    # if you just want <EM>
    re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

    re.search(r'\d*\.?\d*','1432.75+60.22i').group()
    re.search(r'[AGTC]+', 'the sequence ATTCGT').group()
    re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()


    # using re.findall (return list fo the results)
    MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
    emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr)
    for email in emails:
        print(emails)

    # finding in files
    f = open('../data/TestOaksData.csv', 'r')
    found_oaks = re.findall(r"Q[\w\s].*\s", f.read())
    found_oaks
    # the file is closed after reading



    # Groups within muntiple matches
    MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"
    found_matches = re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
    found_matches

    for item in found_matches:
        print(item)



    # Extracting text from webpages
    import urllib3
    conn = urllib3.PoolManager() # open a connection
    r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
    webpage_html = r.data #read in the webpage's contents
    type(webpage_html)
    # So decode it (remember, the default decoding that this method applies is utf-8):
    My_Data  = webpage_html.decode() #print(My_Data)
    # extract all the names of academics:
    pattern = r"Dr\s+\w+\s+\w+"
    regex = re.compile(pattern) # example use of re.compile(); you can also ignore case  with re.IGNORECASE 
    for match in regex.finditer(My_Data): # example use of re.finditer()
        print(match.group())



    #Replacing text
    New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
    # print(New_Data)

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)