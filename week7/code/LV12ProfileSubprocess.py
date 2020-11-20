import subprocess

print("Running LV1...")
subprocess.os.system("ipython3 -m cProfile LV1.py")
print("LV1 Complete!\n\n")

print("Running LV2...")
subprocess.os.system("ipython3 -m cProfile LV2.py 1. 0.1 1.5 0.75 ")
print("LV2 Complete!")