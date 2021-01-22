

rm(list = ls())
graphics.off()

require(ggplot2)

# 1. read the data, starting value and compare models
StartLog <- read.csv("../results/logistic_Starting_Value.csv")
StartGom <- read.csv("../results/gompertz_Starting_Value.csv")

PlotLog <- read.csv("../results/logistic_plot_points.csv")
PlotGom <- read.csv("../results/gompertz_plot_points.csv")

Data <- read.csv('../data/pop.csv')
Data <- Data[order(Data[,'ID'], Data[,'Time']),]

# 2. plot & get AIC of qubic model
AIC_cub <- list()
AICc_cub <- list()
BIC_cub <- list()

for (i in 1:285){
  #browser()
  id <- unique(Data$ID)[i]
  data <- Data[Data$ID == id,]
  
  # qubic model
  fit_lm <- lm(logN~poly(Time, 3), data)
  aic <- AIC(fit_lm)
  n <- nrow(data)
  k <- 4
  aicc <- AIC(fit_lm) + (2*k^2+2*k)/(n-k-1)
  bic <- BIC(fit_lm)
  AIC_cub[[i]] <- c(id, aic)
  AICc_cub[[i]] <- c(id, aicc)
  BIC_cub[[i]] <- c(id, bic)
  
  # plot
  time2plot <- seq(min(data$Time), max(data$Time), length=1000)
  plot_log <- data.frame(time = time2plot,logN = subset(PlotLog, PlotLog$ID==id)$pred_log, model = rep("logistic",1000))
  plot_cub <- data.frame(time = time2plot,logN = predict(fit_lm, newdata = list(Time = time2plot)), model = rep("cubic",1000))
  plot_df <- rbind(plot_cub,plot_log)
  
  if (is.na(subset(StartGom, StartGom$ID==id)$AICc)){
    comp_lable <- paste("AIC_cubic:",aic,"\nAICc_cubic:",aicc,"\nBICc_cubic:",bic,
                        "\nAIC_logistic:",StartLog[i,"AIC"],"\nAICc_logistic:",StartLog[i,"AICc"],"\nBIC_logistic:",StartLog[i,"BIC"])
                        
  }else{
    plot_gom <- data.frame(time = time2plot,logN = subset(PlotGom, PlotGom$ID==id)$pred_gom, model = rep("gompertz",1000))
    plot_df <- rbind(plot_df, plot_gom)
    comp_lable <- paste("\nAICc_cubic:",aicc,"\nAICc_logistic:",StartLog[i,"AICc"],"\nAICc_gompertz:",StartGom[i,"AICc"],
                        "\nAIC_cubic:",aic,"\nAIC_logistic:",StartLog[i,"AIC"],"\nAIC_gompertz:",StartGom[i,"AIC"],
                        "\nBICc_cubic:",bic,"\nBIC_logistic:",StartLog[i,"BIC"],"\nBIC_gompertz:",StartGom[i,"BIC"])
  }
  
  FileName <- paste0("../results/plot_", i,".png")
  png(file = FileName)
  p <- ggplot(data, aes(x=Time, y=logN)) +
    geom_point() +
    labs(x = "Time (h)", y = "Logarithm of the population size (logN)") +
    # ggtitle("Model comparison plot") +
    annotate(geom = 'text', label = comp_lable, x = Inf, y = -Inf, hjust = 0, vjust = -0.2) +
    # stat_smooth(method = lm, level = 0.95, aes(colour="Cubic")) +
    geom_line(data = plot_df ,aes(x = time, y = logN, color = model), size=1)
    # scale_colour_manual(name="Model", values=c("darkblue", "darkred", "darkgreen"))
  print(p)
  graphics.off()
}


# compare AIC,AICc,BIC
AIC_cub_df <- t(as.data.frame(AIC_cub))
AICc_cub_df <- t(as.data.frame(AICc_cub))
BIC_cub_df <- t(as.data.frame(BIC_cub))
# write AIC data frame, delete rows with NA
comp_df <- data.frame(AICc_cub_df,StartLog$AICc,StartGom$AICc,
                      AIC_cub_df[,2],StartLog$AIC,StartGom$AIC,
                      BIC_cub_df[,2],StartLog$BIC,StartGom$BIC)
# delete na
comp_df <- comp_df[complete.cases(comp_df),]
# compare and get better model
colnames(comp_df) <- c("ID","AICc_cub", "AICc_logistic","AICc_gompertz",
                       "AIC_cub","AIC_logistic","AIC_gompertz", 
                       "BIC_cub","BIC_logistic","BIC_gompertz")
comp_df$better_AICc <- colnames(comp_df[,2:4])[apply(comp_df[,2:4],1,which.min)]
comp_df$better_AIC <- colnames(comp_df[,5:7])[apply(comp_df[,5:7],1,which.min)]
comp_df$better_BIC <- colnames(comp_df[,8:10])[apply(comp_df[,8:10],1,which.min)]
# save the compareson data
write.csv(comp_df, "../results/Compare.csv")

# visualize comparison
png("../results//Model_comparasion_AIC.png")
ggplot(comp_df, aes(x = better_AIC)) +
  geom_bar() +
  theme_bw() +
  labs(x = "Model", y = "Count") +
  scale_x_discrete(labels=c("Cubic Model","Gompertz Model","Logistic Model")) +
  geom_text(stat='count', aes(label=..count..), vjust=-1) 
  # ggtitle("Which one is the better model? (by comparing AIC)") +
  # theme(plot.title = element_text(size = 15, hjust = 0.5, face = "bold"))
graphics.off()

png("../results//Model_comparasion_AICc.png")
ggplot(comp_df, aes(x = better_AICc)) +
  geom_bar() +
  theme_bw() +
  labs(x = "Model", y = "Count") +
  scale_x_discrete(labels=c("Cubic Model", "Gompertz Model","Logistic Model")) +
  geom_text(stat='count', aes(label=..count..), vjust=-1) 
graphics.off()

png("../results//Model_comparasion_BIC.png")
ggplot(comp_df, aes(x = better_BIC)) +
  geom_bar() +
  theme_bw() +
  labs(x = "Model", y = "Count") +
  scale_x_discrete(labels=c("Cubic Model", "Gompertz Model","Logistic Model")) +
  geom_text(stat='count', aes(label=..count..), vjust=-1) 
graphics.off()

