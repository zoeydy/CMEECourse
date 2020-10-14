# What does each fo foo_x do?
def foo_1(x):
    return x ** 0.5
foo_1(3)
foo_1(9)
foo_1(49)

def foo_2(x, y):
    if x > y:
        return x
    return y
foo_2(2,3)
foo_2(3,2)

%cpaste
def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]
foo_3(1, 3, 2)

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x):# a recursive function that calculaes the facrotial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x 
        x = x - 1
        return facto
