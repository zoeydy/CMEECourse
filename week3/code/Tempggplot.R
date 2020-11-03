rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass), colour = Type.of.feeding.interaction))
p
p + geom_point()

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass), colour = Type.of.feeding.interaction ))
q <- p + 
  geom_point(size=I(2), shape=I(10)) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1) # make the plot square
q

p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction )) + geom_density()
p 
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction)) + geom_density(alpha=0.5)
p
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction )) +  geom_density() + facet_wrap( .~ Type.of.feeding.interaction)
p
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction )) +  geom_density() + facet_wrap( .~ Type.of.feeding.interaction, scales = "free")
p
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass))) +  
  geom_density() + facet_wrap( .~ Location, scales = "free")
p
# plot the size-ratio distributions by location 
p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Location, scales = "free")
p
# You can also combine categories like this (this will be BIG plot!):
p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Location + Type.of.feeding.interaction, scales = "free")
p
# And you can also change the order of the combination:
p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass))) +  
  geom_point() + facet_wrap( .~ Type.of.feeding.interaction + Location, scales = "free")
p



################## Some useful ggplot2 examples

####### Plotting a matrix
# Because we want to plot a matrix, and ggplot2 accepts only dataframes, 
# we use the package reshape2, which can “melt” a matrix into a dataframe
require(reshape2)
GenerateMatrix <- function(x){
  M <- matrix(runif(x * x), x, x)
  return(M)
}
M <- GenerateMatrix(10)
Melt <- melt(M)
p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + geom_tile() + theme(aspect.ratio = 1)
p
# Add a black line dividing cells
p + geom_tile(colour = "black") + theme(aspect.ratio = 1)
# Remove the legend
p + theme(legend.position = "none") + theme(aspect.ratio = 1)
# Remove all the rest
p + theme(
          legend.position = "none",
          panel.background = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x = element_blank(),
          axis.title.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.y = element_blank()
          )
# Explore some colors
p + scale_fill_continuous(low = "yellow", high = "darkgreen")
p + scale_fill_gradient2()
p + scale_fill_gradientn(colours = grey.colors(10))
p + scale_fill_gradientn(colours = rainbow(10))
p + scale_fill_gradientn(colours = c("red", "white", "blue"))


####### Plotting two dataframes together
