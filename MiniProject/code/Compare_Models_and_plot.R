

rm(list = ls())
graphics.off()

require(ggplot2)
require(minpack.lm)

# 1. define the model function for logistic and gompertz model
model_logistic <- function(t, r_max, N_0, K){
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}
model_gompertz <- function(t, r_max, N_0, K, t_lag){
  return(N_0 + (K-N_0)*exp(-exp((r_max*exp(1)*(t_lag-t))/((K-N_0)*log(10))+1)))
}

# 2. read the data and starting value grouped by ID 
StartLog <- read.csv("../data/logistic_Starting_Value.csv")
StartGom <- read.csv("../data/gompertz_Starting_Value.csv")
Data <- read.csv('../data/pop.csv')

# 3. for loop for comparing models in each ID
AIC <- data.frame(ID = NULL, AIC_cub = NULL, AIC_log = NULL, AIC_gom = NULL, best_model = NULL)
unq_id <-  unique(Data$ID)
for (i in 1:length(unq_id)){
  id <- unq_id[i]
  if (!is.na(StartLog$ID)[i]){
    #browser()
    data <- subset(Data, Data$ID == id)
    
    # fit the cubic model(delete Infs or NAs in data)
    fit_cub <- lm(logPopBio~poly(Time, 3), data)
    AIC_cub <- AIC(fit_cub)
    
    # read starting value(logistic)
    AIC_log <- StartLog[id,3]
    r_max_log <- StartLog[id,4]
    N_0_log <- StartLog[id,5]
    K_log <-StartLog[id,6]
    
    # read starting value(gompertz)
    AIC_gom <- StartGom[id,3]
    r_max_gom <- StartGom[id,4]
    N_0_gom <- StartGom[id,5]
    K_gom <-StartGom[id,6]
    t_lag_gom <- StartGom[id,7]
    
    # comparing and saving AIC value for each model 
    AIC_ID <- data.frame(ID = id, AIC_cub = AIC_cub, AIC_log = AIC_log, AIC_gom = AIC_gom)
    AIC_ID$best_model <- names(AIC_ID[,2:4])[which.min(apply(AIC_ID[,2:4],MARGIN=2,min))]
    AIC_ID$min_AIC <- min(AIC_ID[,2:4])
    #AIC_ID[c("Min_AIC", "Best_model")] <- t(apply(AIC_ID, 1, function(x) c(min(x), names(x[which.min(x)]))))
    AIC <- rbind(AIC, AIC_ID) 
    
    ######## Plot ########
    # generate the data frame contains expected points for each model
    timepoint <- seq(min(data$Time), max(data$Time), len = 700)
    # 1. Polynomial model
    point_cub <- predict.lm(fit_cub, data.frame(Time = timepoint))
    df1 <- data.frame(timepoint, point_cub)
    df1$model <- "Polynomial Model"
    names(df1) <- c('Time', 'LogPopBio', 'Model')
    # 2. logistic model
    logistic_point <-  log(
      model_logistic(t = timepoint,
                     r_max = r_max_log,
                     K = K_log,
                     N_0 = N_0_log)
    )
    df2 <- data.frame(timepoint, logistic_point)
    df2$model <- "Logistic Model"
    names(df2) <- c('Time', 'LogPopBio', 'Model')
    # 3. gompertz model
    gompertz_point <- model_gompertz(t = timepoint,
                                     r_max = r_max_gom,
                                     K = K_gom, 
                                     N_0 = N_0_gom, 
                                     t_lag = t_lag_gom)
    df3 <- data.frame(timepoint, gompertz_point)
    df3$model <- "Gompertz Model"
    names(df3) <- c('Time', 'LogPopBio', 'Model')
    # get the comparing data frame
    model_frame <- rbind(df1,df2,df3)
    # plot
    FileName <- paste("../results/CompaPlot/plot_", i)
    pdf(file = FileName)
    print(
      ggplot(data, aes(x = Time, y = logPopBio)) +
        geom_point(size = 3) +
        geom_line(data = model_frame, aes(x = Time, y = LogPopBio, col = Model), size = 1) +
        theme_bw() +
        theme(aspect.ratio = 1) +
        labs(x = 'Time', y = 'Log(Abundance)')
    )
    graphics.off()
   
  }else{
    AIC_ID <- data.frame(ID = i, AIC_cub = NA, AIC_log = NA, AIC_gom = NA,min_AIC=NA, best_model="No fitting")
    AIC <- rbind(AIC, AIC_ID)
  }
 
}

write.csv(AIC, "../results/AIC.csv")

# visualize comparison
ggplot(AIC, aes(x = best_model)) + geom_bar(show.legend = TRUE)

# plot point ?

