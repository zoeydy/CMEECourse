rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF_New <- data.frame(Prey.mass = MyDF$Prey.mass, 
                       Predator.mass = MyDF$Predator.mass, 
                       PreyPred.Ratio = MyDF$Prey.mass/MyDF$Predator.mass,
                       Feeding.type = MyDF$Type.of.feeding.interaction,
                       stringsAsFactors = F)

# plotting
#("Predator.mass", "Prey.Mass", "Prey.Predator.MassRatio")

for (a in c("Predator.mass", "Prey.Mass", "Prey.Predator.MassRatio")){
  Feeding_type <- unique(MyDF_New$Feeding.type)
  par(mfcol = c (1,5))
  n=1
  for(i in Feeding_type) {
    Subset <- subset(MyDF_New, Feeding_type == i)
    par(mfg=c(1,n))
    n=n+1
    
    boxplot(log(Subset$a) ~ Subset$Feeding.type, 
            xlab = i,
            ylab = a,)
  }
  mtext("Predator mass by feeding interaction type", side=3, outer=TRUE, line=-3)
}



###### calculation
Output <- data.frame(Feeding.type = rep(Feeding_type, each = 2),
                     Result.type= rep(c("Mean", "Median"), 5)
                     
                     )
Type_number <- tapply(rep(1, nrow(MyDF)), MyDF$Type.of.feeding.interaction, sum)

PP_Results.csv <- write.csv( ,"../results/PP_Results.csv")
