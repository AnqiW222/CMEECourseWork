#Loop exmples

# FOR loops
for i in range(5):
    print(i)

my_list = [0,2,"geronimo!",3.0,True,False]
for k in my_list:
    print(k)

total = 0
summands = [0,1,11,111,1111]
for s in summands:
    total  = total +s
    print (total)

# WHILE loops
z=0
while z<100:
    z=z+1
    print (z)

#Functions
def foo(x):
    x *= x # same as x = x*x
    print (x)
    return x

#distinction
def foo(x):
    x *= x # same as x = x*x
    print (x)
    return x
y = foo(2)
y
type(y)
