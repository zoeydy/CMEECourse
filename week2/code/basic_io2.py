############
# FILE OUTPUT
############
# save the elements of a list to a file
list_to_sava = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_sava:
    f.write(str(i) + '/n') ## Add a new line at the end

f.close