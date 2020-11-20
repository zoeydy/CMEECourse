"""profiling examples"""
import sys


"""frofile function"""
def my_squares(iters):
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

"""frofile function"""
def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

"""frofile function"""
"""main funciton to profile last 2 funciton"""
def main(argv):

    def run_my_funcs(x,y):
        print(x,y)
        my_squares(x)
        my_join(x,y)
        return 0
        
    run_my_funcs(10000000,"My string")


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
