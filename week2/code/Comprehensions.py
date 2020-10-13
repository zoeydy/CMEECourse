x = [i for i in range(10)]
print(x)
x = range(10)
print(x)

x = []
for i in range(10):
    x.append(i)
print(x)

# Lower the cases
# 1
x = [i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)
# 2
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)): #explicit loop
    x[i] = x[i].lower()
print(x)
# 3
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
x_new = []
for i in x: #implicit loop
    x_new.append(i.lower())
print (x_new)

# flatten a matrix
# 1
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattend_matrix = []
for row in matrix:
    for n in row:
        flattend_matrix.append(n)
print(flattend_matrix)
# 2
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattend_matrix = [ n for row in matrix for n in row]
print(flattend_matrix)

# extract the first latters in a sequence of words
# 1
words = (["These","are","some","words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])
print(first_letters)
# 2
words = (["These","are","some","words"])
first_letters = {w[0] for w in words}
print(first_letters)