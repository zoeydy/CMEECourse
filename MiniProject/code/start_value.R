
# rm(list = ls())
# graphics.off()
# 
# require(minpack.lm)
# 
# # 1. define function
# model_logistic <- function(t, r_max, N_0, K){
#   return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
# }
# 
# model_gompertz <- function(t, r_max, N_0, K, t_lag){
#   return(N_0 + (K-N_0)*exp(-exp((r_max*exp(1)*(t_lag-t))/((K-N_0)*log(10))+1)))
# }
# 
# GuessStartLog <- function(data, t, r_maxS, N_0S, KS){
#   out <- tryCatch(
#     epr <- {
#       nlsLM(PopBio~model_logistic(t=Time, r_max, N_0, K), data,
#             start = list(r_max = r_maxS, N_0 = N_0S, K = KS))
#     },
#     warning = function(w){
#       #print(w)
#       return(NA)
#     },
#     error = function(e){
#       #print(e)
#       return(NA)
#     }
#   )
#   if (!is.na(out)){
#     AIC <- AIC(out)
#     # calculate the rsq
#     RSS <- sum(residuals(out)^2)
#     TSS <- sum((data$PopBio-mean(data$PopBio))^2)
#     rsq <- 1-(RSS/TSS)
#     #print(AIC)
#     return(c(AIC, rsq, r_maxS, N_0S, KS))
#   }
#   #print(out)
#   return(out)
# }
# 
# GuessStartGom <- function(data, t, r_maxS, N_0S, KS, t_lagS){
#   #browser()
#   out <- tryCatch(
#     epr <- {
#       nlsLM(logPopBio~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
#             start = list(r_max = r_maxS, N_0 = N_0S, K = KS, t_lag = t_lagS))
#     },
#     warning = function(w){
#       #print(w)
#       return(NA)
#     },
#     error = function(e){ 
#       #print(e)
#       return(NA) 
#     }
#   )
#   if (!is.na(out)){
#     AIC <- AIC(out)
#     # calculate the rsq
#     RSS <- sum(residuals(out)^2)
#     TSS <- sum((data$PopBio-mean(data$PopBio))^2)
#     rsq <- 1-(RSS/TSS)
#     #print(AIC)
#     return(c(AIC, rsq, r_maxS, N_0S, KS, t_lagS))
#   }
#   #print(out)
#   return(out)
# }

# # 2. read the data
# Data <- read.csv('../data/pop.csv')
# # sort the data by ID and time
# Data <- Data[order(Data[,2], Data[,4]),]

# ##### 3. subset data, in each data guessing the starting value
# ID <- unique(Data$ID)
# result_log_df <- data.frame()
# result_gom_df <- data.frame()
# for (i in 1:length(ID)) {
#   #browser()
#   # subset the data
#   id <- ID[i]
#   data <- subset(Data[Data$ID == id,])
#   data$logPopBio <- log(data$PopBio)
#   
#   # get starting values
#   N0start <- min(data$PopBio)
#   Kstart <- max(data$PopBio)
#   tlagStart <- data$Time[which.max(diff(diff(data$logPopBio)))]
#   # set the index (for calculating r_max)
#   data$index <- seq(1:nrow(data))
#   index <- data$index[which.max(diff(data$PopBio))]
#   pre_r <- max(diff(data$PopBio))/(data[index+1,"Time"]-data[index,"Time"])
#   
#   # sample the starting value
#   SampTimes <- 1000
#   fact <- 0.5
#   SampMin <- runif(SampTimes,N0start-abs(N0start)*fact,N0start+abs(N0start)*fact)
#   SampMax <- runif(SampTimes,Kstart-abs(Kstart)*fact,Kstart+abs(Kstart)*fact)
#   Samp_r <- runif(SampTimes, pre_r - abs(pre_r)*fact, pre_r + abs(pre_r)*fact)
#   Samp_tlagStart <- runif(SampTimes, t_lag-abs(tlagStart)*fact, t_lag+abs(tlagStart)*fact)
#   
#   # fit two models for each sample (SampTimes times)
#   log_list <- list()
#   gom_list <- list()
#   for (j in 1:SampTimes) {
#     result_log <- GuessStartLog(data,t = Time, r_maxS = Samp_r[j], N_0S = SampMin[j], KS = SampMax[j])
#     log_list[[j]] <- c(id, "logistic" ,result_log)
#     result_gom <- GuessStartGom(data,t = Time, r_maxS = Samp_r[j], N_0S = log(SampMin[j]), KS = log(SampMax[j]), t_lagS = Samp_tlagStart[j])
#     gom_list[[j]] <- c(id, "gompertz" ,result_gom)
#   }
#   log_df <- t(as.data.frame(log_list))
#   gom_df <- t(as.data.frame(gom_list))
#   result_log_df <- rbind(result_log_df, log_df)
#   result_gom_df <- rbind(result_gom_df, gom_df)
# 
# }
# colnames(result_log_df) <- c("ID", "Model", "AIC", "RSq", "r_max", "N_02", "K")
# colnames(result_gom_df) <- c("ID", "Model", "AIC", "RSq", "r_max", "N_02", "K", "t_lag")

#######################################################
# tryr_max <- function(data){
#   tlagStart <- data$Time[which.max(diff(diff(data$logN)))]
#   logN_sta <- min(data$logN) + 6/7 * (max(data$logN) - min(data$logN))
#   t_sta <- min(data$Time[which(data$logN > logN_sta)])
#   out <- tryCatch(
#     epr <- {
#       lm(logN~Time, data[data$Time > tlagStart & data$Time < t_sta,])
#     },
#     warning = function(w){
#       print(w)
#       return(unique(data$ID))
#     },
#     error = function(e){
#       print(e)
#       return(unique(data$ID)) 
#     }
#   )
#   
#   if (length(out) == 1){
#     return(NA)
#   }else{
#     return(out)
#   }
#   
# }


# ### try catch r_max
# para <- tryr_max(data)
# if(is.na(para)){
#   start_value_df <- rbind(start_value_df, c(id, "gompertz", rep("Error",6)))
#   plot(data$Time, data$logN)
# }else{
#   tlagStart <- data$Time[which.max(diff(diff(data$logN)))] # find last timepoint of lag phase
#   rStart <- coef(para)[2]







########### test gompertz ##############

rm(list = ls())
graphics.off()


require(minpack.lm)


# 1. define model and starting_value_guess functions
model_gompertz <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(  -exp( r_max * exp(1) * (t_lag - t)/(K - N_0) * log(10) + 1 )  ))
}

GuessStart <- function(data, t, r_maxS, N_0S, KS, t_lagS){
  #browser()
  out <- tryCatch(
    epr <- {
      nlsLM(logN~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
            start = list(r_max = r_maxS, N_0 = N_0S, K = KS, t_lag = t_lagS))
    },
    warning = function(w){
      #print(w)
      return(NA)
    },
    error = function(e){ 
      #print(e)
      return(NA) 
    }
  )
  if (!is.na(out)){
    AIC <- AIC(out)
    # calculate the rsq
    RSS <- sum(residuals(out)^2)
    TSS <- sum((data$PopBio-mean(data$PopBio))^2)
    rsq <- 1-(RSS/TSS)
    #print(AIC)
    return(c(AIC, rsq, r_maxS, N_0S, KS, t_lagS))
  }
  #print(out)
  return(out)
}

# 2. read the Data
Data <- read.csv('../data/pop.csv')
Data <- subset(Data, Data$PopBio > 0)
Data$logN <- log(Data$PopBio)
#Data <- subset(Data[!is.na(Data$logN),])
Data <- Data[order(Data[,2], Data[,4]),]


# 3. writing for loop to get the best value for each ID_data by comparing AIC
start_value_df <- data.frame(ID=NULL,Model=NULL,AIC=NULL,RSq=NULL,r_max=NULL, N_0=NULL, K=NULL, t_lag = NULL)
for (i in 1:length(unique(Data$ID))){
  
  # subset the Data by ID 
  id <- unique(Data$ID)[i]
  data <- subset(Data, Data$ID == id)
  
  
  #############test
  plot(data$Time, data$logN)
  test_df <- data[data$Time>20 & data$Time<200,]
  plot(test_df$Time, test_df$logN)
  lm(logN~Time, test_df)
  model_gompertz(t = data$Time,r_max = rStart,K = Kstart,N_0 =N0start,t_lag =tlagStart  )
  nlsLM(logN~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
        start = list(r_max = rStart, N_0 = N0start, K = Kstart, t_lag = tlagStart),
        lower = c(0,-7,-1,-50))
  nlsLM(logN~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
        start = list(r_max = 0.03274235, N_0 = -5, K = -1, t_lag = 0))
  result <- GuessStart(data,t = Time, r_maxS = rStart, N_0S = N0start, KS = Kstart,t_lagS = tlagStart)
  #########################
  
  # get starting values
  N0start <- min(data$logN)
  Kstart <- max(data$logN)
  tlagStart <- data$Time[which.max( diff( diff(data$logN)/diff(data$Time) )/(diff(diff(data$Time))) )]
  # r_max
  interval <- max(data$logN) - min(data$logN)
  pop_low <- min(data$logN) + 0.25*interval
  pop_high <- min(data$logN) + 0.75*interval
  if (length(data$Time) <= 5) {
    lm_fit <- lm(logN~Time, data)
  }else{
    if (nrow(data[data$logN > pop_low & data$logN < pop_high,])<2) {
      lm_fit <- lm(logN~Time, data[data$logN > min(data$logN) + 0.05*interval &
                                     data$logN < min(data$logN) + 0.95*interval,])
    }else{
      lm_fit <- lm(logN~Time, data[data$logN > pop_low & data$logN < pop_high,])
    }
  }
  rStart <- coef(lm_fit)[2]

  
  # set the sample time and factor
  SampTime <- 1000
  fact <- 0.2
  
  # sample the starting value
  SampMin <- runif(SampTime,N0start-abs(N0start)*fact,N0start+abs(N0start)*fact)
  SampMax <- runif(SampTime,Kstart-abs(Kstart)*fact,Kstart+abs(Kstart)*fact)
  Samp_r_max <- runif(SampTime, 0, rStart + abs(rStart)*fact)
  Samp_t_lag <- runif(SampTime, tlagStart-abs(tlagStart)*fact, tlagStart+abs(tlagStart)*fact)
    
  # fitting with each sample value
  result_list <- list()
  for (j in 1:SampTime){
    result <- GuessStart(data,t = Time, r_maxS = Samp_r_max[j], N_0S = SampMin[j], KS = SampMax[j],t_lagS = Samp_t_lag[j])
    if(!is.na(result)){
      result_list[[j]] <- c(id, "gompertz", result)
    }
    # delete NULL
    result_list<-result_list[!sapply(result_list,is.null)]
  }
    
  if(is.null(unlist(result_list))){
    start_value_df <- rbind(start_value_df, c(id, "gompertz", rep(NA,6)))
    colnames(start_value_df) <- c("ID","Model","AIC","RSq","r_max","N_0","K","t_lag")
  }else{
    result_df <- data.frame(matrix(unlist(result_list), nrow=length(result_list), byrow=T))
    colnames(result_df) <- c("ID","Model","AIC","RSq","r_max","N_0","K","t_lag")
    result_df <- subset(result_df[result_df$AIC== min(result_df$AIC), ])
    if(nrow(result_df)>1){
      result_df <- result_df[1,]
    }
    start_value_df <- rbind(start_value_df, result_df)
  }
}
  # # t_lag
  # tlagStart <- data$Time[which.max(diff(diff(data$logN)))] # find last timepoint of lag phase
  # # r_max
  # logN_sta <- min(data$logN) + 6/7 * (max(data$logN) - min(data$logN))
  # t_sta <- min(data$Time[which(data$logN > logN_sta)])
  # rStart <- tryr_max
  
  
  
  
  


# 4. save the starting value for each ID into csv
write.csv(final_start_value, "../data/gompertz_Starting_Value.csv")
