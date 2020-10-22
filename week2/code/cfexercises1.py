#~!/usr/bin/env python3

"""Some functions doing arithmatic."""

__appname__ = 'cfexercises1'
__author__ = 'Zongyi Hu (zh2720@ic.ac.uk)'
__version__ = '0.0.1'

import sys

def foo_1(x = 1):
    return x ** 0.5
foo_1(3)
foo_1(9)
foo_1(49)

def foo_2(x=1, y=1):
    if x > y:
        return x
    return y
foo_2(2,3)
foo_2(3,2)

def foo_3(x=1, y=1, z=1):
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

def foo_4(x=1):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x=1):# a recursive function that calculaes the facrotial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x=1): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x 
        x = x - 1
        return facto
    

def main(argv):
    print(foo_1())
    print(foo_2())
    print(foo_3())
    print(foo_4())
    print(foo_5())
    print(foo_6())
    return(0)

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)