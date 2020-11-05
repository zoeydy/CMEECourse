# plotting
rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
require(ggplot2)


pdf("../results/PP_Regress.pdf")

print(
  p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass), 
                        colour = Predator.lifestage)) +
    geom_point(shape = 3) +
    labs(x = "Prey mass in grams", y = "Predator mass in grams") +
    geom_smooth(method='lm', fullrange = TRUE) +
    facet_grid(Type.of.feeding.interaction ~. , scales = "free") +
    theme(legend.position = "bottom") +
    guides(col = guide_legend(nrow=1))
)

graphics.off()

# calculation
FeedingType <- unique(MyDF$Type.of.feeding.interaction)
DF <- data.frame(FeedingType = NULL,
                 LifeStage = NULL,
                 Slope = NULL,
                 Intercept = NULL,
                 R2 = NULL,
                 f.value = NULL,
                 P.value = NULL,
                 stringsAsFactors=FALSE) 

for(a in 1:length(FeedingType)){
  Subset1 <- subset(MyDF, Type.of.feeding.interaction == FeedingType[a])
  LifeStage <- unique(Subset1$Predator.lifestage)
  for (b in 1:length(LifeStage)){
    # browser()
    Subset2 <- subset(Subset1, Predator.lifestage == LifeStage[b])
    Model <- lm(log(Predator.mass)~log(Prey.mass), data = Subset2)
    Output <- summary(Model)
    if(is.null(Output$fstatistic[1])  == TRUE){
      DF2 <- data.frame(FeedingType = FeedingType[a],
                       LifeStage = LifeStage[b],
                       Slope = NA,
                       Intercept = NA,
                       R2 = NA,
                       f.value = NA,
                       P.value = NA,
                       stringsAsFactors=FALSE) 
    } else{
      DF2 <- data.frame(FeedingType = FeedingType[a], LifeStage = LifeStage[b],
                        Slope = Output$coefficients[2,1], Intercept = Output$coefficients[1,1], 
                        R2 = Output$r.squared, f.value = Output$fstatistic[1], P.value = Output$coefficients[8])
    }
    DF <- rbind(DF,DF2)
  }
}

write.csv(DF, "../results/PP_Regress_Results.csv", row.names=FALSE)
