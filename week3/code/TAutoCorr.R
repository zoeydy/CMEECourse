rm(list = ls())
load("../data/KeyWestAnnualMeanTemperature.RData")

ats2 <- data.frame(Temp1 = ats$Temp[1:length(ats$Temp)-1], Temp2 = ats$Temp[2:length(ats$Temp)])
cor0 <- cor(ats2$Temp1, ats2$Temp2)
# nrow(ats)
# length(ats$Temp)

cor_list <- vector()
for(i in 1:10000){
  shuffle <- data.frame(shuffle1 = sample(ats2$Temp1, length(ats2$Temp1), replace = FALSE), 
                        shuffle2 = sample(ats2$Temp2, length(ats2$Temp2), replace = FALSE))
  cor_list <- c(cor_list, cor(shuffle$shuffle1, shuffle$shuffle2))
}

biger_num <- subset(cor_list, cor_list > cor0)

p <- length(biger_num)/10000

# plot(1:10000, cor_list)

# save the graph in jpg
png(file="../results/cor_list.png",
    width=600, height=350)
hist(cor_list)
dev.off()
hist(cor_list)