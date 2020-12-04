

rm(list = ls())
graphics.off()


require(minpack.lm)


# 1. define model and starting_value_guess functions
model_gompertz <- function(t, r_max, N_0, K, t_lag){
  return(N_0 + (K-N_0)*exp(-exp((r_max*exp(1)*(t_lag-t))/((K-N_0)*log(10))+1)))
}

GuessStart <- function(data, t, r_maxS, N_0S, KS, t_lagS){
  #browser()
  out <- tryCatch(
    epr <- {
      nlsLM(logPopBio~model_gompertz(t=Time, r_max, N_0, K, t_lag), data,
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
    #print(AIC)
    return(c(AIC, r_maxS, N_0S, KS, t_lagS))
  }
  #print(out)
  return(out)
}

# 2. read the Data
Data <- read.csv('../data/pop.csv')



# 3. writing for loop to get the best value for each ID_data by comparing AIC
final_start_value <- data.frame(ID=NULL, AIC=NULL, r_max=NULL, N_0=NULL, K=NULL, t_lag = NULL)
for (i in 1:length(unique(Data$ID))){
  # subset the Data by ID 
  id <- unique(Data$ID)[i]
  data <- subset(Data, Data$ID == id)
  
  
  # get the preliminary r_max
  if (length(data$ID)<8){
    lm_growth <- lm(logPopBio ~ Time, data)
  }else{
    rag <- range(data$Time)[2]-range(data$Time)[1]
    lm_growth <- lm(logPopBio ~ Time, data= data[data$Time > (min(data$Time) + 1/5*(rag)) & data$Time < (min(data$Time) + 1/2*(rag)),])
  }
  pre_r <- as.numeric(coef(lm_growth)[2])
  
  
  # get the end time of the lag phrase(t_lag)
  t_lag_guess <- data$Time[which.max(diff(diff(data$logPopBio)))]
  
  # set the sample time and factor
  SampTime <- 1000
  fact <- 1
  
  # sample the starting value
  SampMin <- runif(SampTime,min(data$logPopBio)-abs(min(data$logPopBio))*fact,min(data$logPopBio)+abs(min(data$logPopBio))*fact)
  SampMax <- runif(SampTime,max(data$logPopBio)-abs(max(data$logPopBio))*fact,max(data$logPopBio)+abs(max(data$logPopBio))*fact)
  Samp_r_max <- runif(SampTime,pre_r - abs(pre_r)*fact, pre_r + abs(pre_r)*fact)
  Samp_t_lag <- runif(SampTime, t_lag_guess-abs(t_lag_guess)*fact, t_lag_guess+abs(t_lag_guess)*fact)
  
  # for loop in each ID for finding starting value 
  result_ID <- data.frame(ID=NULL, AIC=NULL,N_0=NULL, r_max=NULL,K=NULL, t_lag=NULL)
  for (j in 1:SampTime){
    result<- GuessStart(data,t = Time, r_maxS = Samp_r_max[j], N_0S = SampMin[j], KS = SampMax[j], t_lagS = Samp_t_lag[j])
        
    if(is.na(result)){
      df <- data.frame(ID=id ,AIC=NA, r_max=NA,N_0=NA,K=NA,t_lag=NA)
    }else{
      df <- data.frame(ID=id ,AIC=result[1],N_0=result[2], r_max=result[3],K=result[4],t_lag=result[5])
    }
    result_ID <- rbind(result_ID, df)
  }
  start_value <- subset(result_ID, result_ID$AIC == min(na.omit(result_ID$AIC)))
  final_start_value <- rbind(final_start_value, start_value[1,])
}

# 4. save the starting value for each ID into csv
write.csv(final_start_value, "../data/gompertz_Starting_Value.csv")
