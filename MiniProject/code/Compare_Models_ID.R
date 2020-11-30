

rm(list = ls())
graphics.off()

require(ggplot2)


# 1. define the model and fitting function for logistic and gompertz model
model_logistic <- function(t, r_max, N_0, K){
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}
model_gompertz <- function(t, r_max, N_0, K, t_lag){
  return(N_0 + (K-N_0)*exp(-exp((r_max*exp(1)*(t_lag-t))/((K-N_0)*log(10))+1)))
}

fit_logistic <- nlsLM(PopBio~model_logistic(t=Time, r_max, N_0, K), data,
                      start = list(r_max = r_max, N_0 = N_0, K = K))
fit_gompertz <- nlsLM(logPopBio~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
      start = list(r_max = r_max, N_0 = N_0, K = K, t_lag = t_lag))

# 2. read the data and starting value for each ID 
StartLog <- read.csv("../data/logistic_Starting_Value.csv")
StartGom <- read.csv("../data/gompertz_Starting_Value.csv")
Data <- read.csv('../data/PopData.csv')

# 3. for loop for comparing models in each ID
AIC_ID <- data.frame(ID = NULL, AIC_cub = NULL, AIC_log = NULL, AIC_gom = NULL, best_model = NULL)
for (i in 1:length(unique(Data$ID))){
  # subset data by ID
  data <- subset(Data, Data$ID == unique(Data$ID)[i])
  # fit the cubic model
  fit_cub <- lm(PopBio~poly(Time, 3), data)
  # getting, comparing and saving AIC value for each model 
  AIC_cub <- AIC(fit_cub)
  AIC_log <- startlog$AIC
  AIC_gom <- startgom$AIC
  
  AIC <- data.frame(ID = unique(Data$ID)[i], 
                    AIC_cub = AIC_cub, AIC_log = AIC_log, AIC_gom = AIC_gom)
  
  AIC[c("Min", "Best_model")] <- t(apply(AIC, 1, function(x) c(min(x), names(x[which.min(x)]))))
  
  
  # # read the non-linear starting value for each ID 
  # startlog <- subset(StartLog, StartLogID == unique(Data$ID)[i])
  # startgom <- subset(StartGom, StartGomID == unique(Data$ID)[i])
  # 
  # # fit the model to get points to plot
  # 

}




