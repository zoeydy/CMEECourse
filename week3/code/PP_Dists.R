rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF_New <- data.frame(Prey.mass = log(MyDF$Prey.mass), 
                       Predator.mass = log(MyDF$Predator.mass), 
                       SizeRatio = log(MyDF$Prey.mass/MyDF$Predator.mass),
                       Feeding.type = MyDF$Type.of.feeding.interaction,
                       stringsAsFactors = F)

####### plotting
FileName <- c("Pred_Subplots.pdf", "Prey_Subplots.pdf", "SizeRatio_Subplots.pdf")
DataType <- c("Predator.mass", "Prey.mass", "SizeRatio")
FeedingType <- unique(MyDF_New$Feeding.type)


for (a in 1: length(DataType)){
  pdf(paste("../results/",FileName[a]), 11.7, 8.3)
  par(mfcol = c(1,5))
  for(i in FeedingType) {
    #browser()
    Subset <- subset(MyDF_New, Feeding.type == i)
    temp <- Subset[,names(Subset)== DataType[a]]
    plot(density(temp), xlab=i, ylab="Density", main="")
    # density(temp$a)
    # boxplot(log(Subset$a) ~ Subset$Feeding.type, 
    #         xlab = i,
    #         ylab = a,)
    mtext(paste(DataType[a]," by feeding interaction type"), side=3, outer=TRUE, line=-3)
  }
  graphics.off()
}


####### calculation

MeanDF <- data.frame()
MedianDF <- data.frame()

for (i in 1:length(FeedingType)) {
  # browser()
  Subset <- subset(MyDF_New, Feeding.type == FeedingType[i])
  MeanDF <- rbind(MeanDF, t(data.frame(apply(Subset[,-ncol(MyDF_New)], 2, mean))))
  MedianDF <- rbind(MedianDF, t(data.frame(apply(Subset[,-ncol(MyDF_New)], 2, median))))
}

# Set dataframe names
row.names(MeanDF) <- FeedingType
row.names(MedianDF) <- FeedingType
names(MeanDF) <- paste(DataType, "Mean")
names(MedianDF) <- paste(DataType, "Median")


OutputDF <- rbind(t(MeanDF), t(MedianDF))
write.csv(OutputDF ,"../results/PP_Results.csv")








# MeanOutput <- list(NA * 5)
# MedianOutput <- list(NA * 5)
# for (i in 1:length(FeedingType)){
#   Subset <- subset(MyDF_New, Feeding.type == FeedingType[i])
#   MeanOutput[[i]] <- apply(Subset[,-ncol(MyDF_New)], 2, mean)
#   MedianOutput[[i]] <- apply(Subset[,-ncol(MyDF_New)], 2, median)
# }
# MeanOutput
# MedianOutput