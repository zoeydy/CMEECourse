# running this script using subprocess to run fmr.R to generate the result we want
# print the output and whether this script runs correctly


import subprocess as sp

p = sp.Popen(["Rscript", "fmr.R"], stdout=sp.PIPE, stderr=sp.PIPE)   
# res = tuple (stdout, stderr)
res = p.communicate()
if p.returncode == 0:
    print("success")
    for line in res[0].decode(encoding='utf-8').split('\n'):
        print(line)

if res[1] != 0:
    print("error:", res[0].decode(encoding='utf-8'))

