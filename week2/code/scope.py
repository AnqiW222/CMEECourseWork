#!/usr/bin/env python3

"""blocks of code illustrating variable scope."""

__appname__ = 'scope'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

#_a_global = 10 # a global cariable

#if _a_global >= 5:
#    _b_global = _a_global + 5 # also a global variable

#print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
#print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function1():
    """Demonstrate that if global variables are altered within a function, they will remain as they were outside of the function;
    local variables are not available outside of the scope of the function they are created in."""
    _a_global = 4 # a local variable

    if _a_global >= 4:
        _b_global = _a_global +5 # also a local variable

    _a_local =3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
    return None 

#a_function1()

#print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
#print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)

#print("After calling a_function, outside the function, the value of _a_local is ", _a_local)  

###################################################################
#_a_global = 10

def a_function2():
    """Demonstrate global variables are available within functions"""
    _a_local = 4
    
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
    return None
    
#a_function2()

#print("Outside the function, the value of _a_global is", _a_global)

####################################################################
#_a_global = 10

#print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function3():
    """Global variables can be altered from within a function"""
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
    return None
    
#a_function3()

#print("After calling a_function, outside the function, the value of _a_global now is", _a_global)

#####################################################################

def a_function4():
    """Nested functions to demonstrate the global keyword will alter local variables globally"""
    _a_global = 10

    def _a_function4_2():
        """Makes the local variable _a_global a global variable, and changes its value globally."""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function4_2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
    return None
    
#a_function4()

#print("The value of a_global in main workspace / namespace now is", _a_global)

#################################################################

# _a_global = 10

def a_function5():
    """Nested function to demonstrate that if a variable is defined globally, when altered using the global keyword it's value will be altered everywhere."""

    def _a_function5_2():
        """Alters a global variable using the global keyword."""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function5_2, value of _a_global is ", _a_global)

    _a_function5_2()
    
    print("After calling _a_function5_2, value of _a_global is ", _a_global)

# a_function5()

# print("The value of a_global in main workspace / namespace is ", _a_global)
