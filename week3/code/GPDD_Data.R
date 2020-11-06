# install.packages("maps")

rm(list = ls())
require(maps)
load("../data/GPDDFiltered.RData")

map(database = "world")
points(gpdd$long, gpdd$lat, pch=20, cex = .5, col = "red")

## The bias is that the points are all concentrated in Europe and North America,
## so the result we get from this data set may be hard to generalize