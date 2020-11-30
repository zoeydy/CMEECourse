
import pandas as pd
import numpy as np
import seaborn as sns

data = pd.read_csv("../data/LogisticGrowthData.csv")
pd.read_csv("../data/LogisticGrowthMetaData.csv")

# insert column ID 
data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)

# delete the negative data
data = data[data['PopBio'] >0]

# insert the logPopBio column
data['logPopBio'] = np.log(data['PopBio'])

# save the new data frame as a new csv file in PopData directory
data.to_csv("../data/PopData.csv")
