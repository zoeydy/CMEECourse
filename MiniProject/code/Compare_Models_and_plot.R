

rm(list = ls())
graphics.off()

require(ggplot2)

# 1. read the data, starting value and compare models
StartLog <- read.csv("../results/logistic_Starting_Value.csv")
StartGom <- read.csv("../results/gompertz_Starting_Value.csv")

PlotLog <- read.csv("../results/logistic_plot_points.csv")
PlotGom <- read.csv("../results/gompertz_plot_points.csv")

Data <- read.csv('../data/pop.csv')
Data <- subset(Data, Data$PopBio > 0)
Data$logN <- log(Data$PopBio)
Data <- subset(Data[!is.na(Data$logN),])
Data <- Data[order(Data[,2], Data[,4]),]

# 2. plot & get AIC of qubic model
AIC_cub <- list()
for (i in 1:285){
  #browser()
  id <- unique(Data$ID)[i]
  data <- Data[Data$ID == i,]
  
  # qubic model
  fit_lm <- lm(logN~poly(Time, 3), data)
  aic <- AIC(fit_lm)
  AIC_cub[[i]] <- c(id, aic)
  
  # plot
  if (is.na(unique(subset(StartGom, StartGom$ID==id)$AIC))){
    next
  }else{
    time2plot <- seq(min(data$Time), max(data$Time), length=1000)
    plot_log <- data.frame(time = time2plot,logN = subset(PlotLog, PlotLog$ID==id)$pred_log, model = rep("logistic",1000))
    plot_gom <- data.frame(time = time2plot,logN = subset(PlotGom, PlotGom$ID==id)$pred_gom, model = rep("gompertz",1000))
    plot_cub <- data.frame(time = time2plot,logN = predict(fit_lm, newdata = list(Time = time2plot)), model = rep("cubic",1000))
    plot_df <- rbind(plot_cub,plot_log, plot_gom)
    
    FileName <- paste("../results/ComparePlot/plot_", i)
    pdf(file = FileName)
    
    AIClable <- paste("AIC_cubic:",aic,"\nAIC_logistic:",StartLog[i,"AIC"],"\nAIC_gompertz:",StartGom[i,"AIC"])
    p <- ggplot(data, aes(x=Time, y=logN)) +
      geom_point() +
      ggtitle(paste0("Model comparison plot (ID = ",id, ")")) + 
      annotate(geom = 'text', label = AIClable, x = Inf, y = -Inf, hjust = 1.1, vjust = -0.3) +
      # stat_smooth(method = lm, level = 0.95, aes(colour="Cubic")) +
      geom_line(data = plot_df ,aes(x = time, y = logN, color = model), size=1) +
      scale_colour_manual(name="Model", values=c("darkblue", "darkred", "darkgreen"))
    print(p)
    graphics.off()
  }
}

AIC_cub_df <- t(as.data.frame(AIC_cub))
# write AIC data frame, delete rows with NA
AIC_df <- data.frame(AIC_cub_df[,1],AIC_cub_df[,2],StartLog$AIC, StartGom$AIC)
# delete na
AIC_df <- AIC_df[complete.cases(AIC_df),]
# compare and get better model
colnames(AIC_df) <- c("ID","lm", "logistic", "gompertz")
AIC_df$better_model <- colnames(AIC_df[,2:4])[apply(AIC_df[,2:4],1,which.min)]
# save the compareson data
write.csv(AIC_df, "../results/Compare_AIC.csv")
# visualize comparison
pdf(file = "../results/Model_comparasion")
ggplot(AIC_df, aes(x = better_model)) + 
  geom_bar() +
  theme_bw() +
  geom_text(stat='count', aes(label=..count..), vjust=-1) +
  ggtitle("Which one is the better model (by comparing AIC)") +
  theme(plot.title = element_text(size = 15, hjust = 0.5, face = "bold"))
graphics.off()

