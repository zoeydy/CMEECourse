"""using subprocess"""
import sys

"""define main function"""

def main(argv):

    import subprocess
    p = subprocess.Popen(["echo", "I'm talkin' to you, bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)