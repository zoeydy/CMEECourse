"""function to buggy"""
"""calculation "x-1/x"""
def buggyfunc(x):
    y = x
    for i in range(x):
        y = y-1
        z = x/y
    return z

buggyfunc(20)