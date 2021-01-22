""" Runs the LV1.py, LV2.py, LV3.py, LV4.py and LV5.py with the appropriate parameters using 
                subprocess and checks for speed bottlencks using CProfile. """


# Running the scripts with the appropriate parameters

import subprocess

p = subprocess.Popen(["python3", "LV1.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
stdout, stderr = p.communicate()
print(stdout.decode())

q = subprocess.Popen(["python3", "LV2.py", "1", "0.5", "1.5", "0.75"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
stdout, stderr = q.communicate()
print(stdout.decode())

r = subprocess.Popen(["python3", "LV3.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
stdout, stderr = r.communicate()
print(stdout.decode())

s = subprocess.Popen(["python3", "LV4.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
stdout, stderr = s.communicate()
print(stdout.decode())

t = subprocess.Popen(["python3", "LV5.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
stdout, stderr = t.communicate()
print(stdout.decode())

# Profiling the scripts
import cProfile

u = subprocess.Popen(["python3", "-m", "cProfile", "LV1.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = u.communicate()
print(stdout.decode())

v = subprocess.Popen(["python3", "-m", "cProfile", "LV2.py", "1", "0.5", "1.5", "0.75"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = v.communicate()
print(stdout.decode())

w = subprocess.Popen(["python3", "-m", "cProfile", "LV3.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = w.communicate()
print(stdout.decode())

x = subprocess.Popen(["python3", "-m", "cProfile", "LV4.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = x.communicate()
print(stdout.decode())

z = subprocess.Popen(["python3", "-m", "cProfile", "LV5.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = z.communicate()
print(stdout.decode())


# Alternative way to CProfile, using the magic command %run -p as it is

#from IPython.terminal.embed import InteractiveShellEmbed

#ipshell = InteractiveShellEmbed()
#ipshell.dummy_mode = True
#ipshell.magic("%run -p LV1.py")
#ipshell.magic("%run -p LV2.py 1 0.1 0.5 0.75 80")
#ipshell.magic("%run -p LV3.py")
#ipshell.magic("%run -p LV4.py")
#ipshell.magic("%run -p LV5.py")
#ipshell()