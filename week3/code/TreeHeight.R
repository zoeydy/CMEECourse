# This function calculates heights of trees given distance of each tree
# form its base and angle to its top, using the trigonometric formula
# 
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees: The angle of elevation of tree
# distance: The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

trees_data <- read.csv("../data/trees.csv", header = TRUE)

TreeHeight <- function(degrees,distance){
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste('Tree height is', height))

    return(height)
}

TreeHeight(37, 40)

trees_data$Tree.Height.m = TreeHeight(trees_data$Angle.degrees,trees_data$Distance.m)
write.csv(trees_data, "../results/TreeHts.csv", row.names = F)
