import sys



"""frofile function"""
def my_squares(iters):
    out = [i ** 2 for i in range(iters)]
    return out

"""frofile function"""
def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += ", " + string
    return out






"""define main function"""

def main(argv):
    """frofile function"""
    def run_my_funcs(x,y):
        print(x,y)
        my_squares(x)
        my_join(x,y)
        return 0

    run_my_funcs(10000000,"My string")


    
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)