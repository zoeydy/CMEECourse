################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) # t():exchange columns and rows
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

# check if the first row is column name in R
colnames(MyData)
# so manually delete the first row when transferring MyData into dataframe
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
# MyData is a matrix, TempData trun it into a frame without the first row, for later assign it as column name
colnames(TempData) <- MyData[1,] # assign column names from original data
# row names are not really bothering us, but we can get rid of it by:
rownames(TempData) <- NULL
head(TempData)

############# Convert from wide to long format  ###############
install.packages("reshape2")
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
# id = c("data", "...save columns...", variable.name = "" # melt data's name, value.name = "" # the name of variable's value)

# change data type of each column
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
# tidyverse
# !!!!!!!!!!!!!!!!!!!!!!!!!
# install.packages(c("tidyverse"))
# sudo apt install r-cran-tidyverse
require(tidyverse)
# list the package to if there are some name-conflict-masking messages
tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 



