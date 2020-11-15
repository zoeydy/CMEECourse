# Coalescence theory

rm(list = ls())
graphics.off()

# set the length of the region
len <- 50000

# read data
data_N <- as.matrix(read.csv("../data/killer_whale_North.csv")) 
data_S <- as.matrix(read.csv("../data/killer_whale_South.csv"))
