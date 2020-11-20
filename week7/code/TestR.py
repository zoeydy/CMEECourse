"""using subprocess to running Rscript"""

import subprocess
import sys

"""running R """
def main(argv):

    subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)