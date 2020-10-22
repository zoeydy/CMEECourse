_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable

"""learning global and local variable"""
def a_function():
    _a_global = 5 # a local variable

    if _a_global >= 5:
        _b_global = _a_global + 5 # also a local variable

    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None
a_function()

print("Outside of the function, the value of _a_global is", _a_global)
print("Outside of the function, the value of _b_global is", _b_global)


_a_global = 10

""" the difference of inside or outside the funtion"""
def b_function():
    _a_local = 4

    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

    return None
a_function()

print("Outside the function, the value of _a_global is", _a_global)


""" using global keyword to ssign a global variable from inside a function"""
_a_global = 10

print("Outside the function, the value of _a_global is", _a_global)

def c_function():
    global _a_global
    _a_global = 5
    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None
a_function()

print("Outside the function, the value of _a_global now is",_a_global)


""" global keyword works inside the nested functions"""
"""function in function"""
def d_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling a_function, value of _a_global is", _a_global)

    _a_function2

    print("After calling _a_function2, value of _a_global is", _a_global)

    return None
a_function()

print("The value of a_global in main workspace / namespace is", _a_global)


_a_global = 10

"""befor or after calling the function"""
"""function in function"""
def e_function():
    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling a_function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)