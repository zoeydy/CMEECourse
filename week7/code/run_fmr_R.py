"""running this script using subprocess to run fmr.R to generate the result we want"""
"""print the output and whether this script runs correctly"""


import subprocess as sp
import sys


"""define main function"""
def main(argv):


    p = sp.Popen(["Rscript", "fmr.R"], stdout=sp.PIPE, stderr=sp.PIPE)   
    # res = tuple (stdout, stderr)
    res = p.communicate()

    print("stdout:")
    print(res[0].decode(encoding='utf-8'))

    if p.returncode == 0:
        print("+==========+\n| Success! |\n+==========+")
    else:
        print("Error:", res[0].decode(encoding='utf-8'))
        print("stderr")
        print(res[1].decode(encoding='utf-8'))

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)

