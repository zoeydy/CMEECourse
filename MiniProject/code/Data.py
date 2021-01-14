
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pylab as plt
import subprocess as sp

############## dealing the data ##############
# read the data
data = pd.read_csv("../data/LogisticGrowthData.csv")
meta = pd.read_csv("../data/LogisticGrowthMetaData.csv")

# insert column ID 
data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)

# # create dictionary change ID
# dict ={}

# numbers = list(range(1,286,1))
# Unq = data.ID.unique()

# for i in range(len(Unq)):
#     dict.update({Unq[i]:numbers[i]})

# data.ID = [dict[item] for item in data.ID]

# delete negative popbio


# save new data frame
data.to_csv("../data/test.csv")



# ############## subprocess R doing model fitting ##############
# p1 = sp.Popen(["Rscript", "LogStart.R"], stdout=sp.PIPE, stderr=sp.PIPE)   
# # res = tuple (stdout, stderr)
# res1 = p1.communicate()

# print("stdout:")
# print(res1[0].decode(encoding='utf-8'))

# if p1.returncode == 0:
#     print("+==========+\n| Success! |\n+==========+")
# else:
#     print("Error:", res1[0].decode(encoding='utf-8'))
#     print("stderr")
#     print(res1[1].decode(encoding='utf-8'))

