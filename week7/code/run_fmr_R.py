# running this script using subprocess to run fmr.R to generate the result we want
# print the output and whether this script runs correctly


import subprocess

retcode = subprocess.call(['fmr.R', '--vanilla', 'T:/2012.R'], shell=True)
subprocess.call ("/usr/bin/Rscript --vanilla fmr.R", shell=True)
subprocess.call (["/usr/bin/Rscript", "--vanilla", "fmr.R"], shell=True)

subprocess.os.system("Rscript fmr.R")

subprocess.Popen("Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait()
