# install.packages("maps")

rm(list = ls())
require(maps)
load("../data/GPDDFiltered.RData")

map(database = "world")
points(gpdd$long, gpdd$lat, pch=20, cex = .5)
