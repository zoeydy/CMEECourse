
rm(list = ls())
graphics.off()


require(minpack.lm)


# 1. define model and starting_value_guess functions
model_logistic <- function(t, r_max, N_0, K){
  return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

GuessStart <- function(data, t, r_maxS, N_0S, KS){
  out <- tryCatch(
    epr <- {
      nlsLM(PopBio~model_logistic(t=Time, r_max, N_0, K), data,
            start = list(r_max = r_maxS, N_0 = N_0S, K = KS))
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
    return(c(AIC, r_maxS, N_0S, KS))
  }
  #print(out)
  return(out)
}


# 2. read the data
Data <- read.csv('../data/pop.csv')


# 3. writing for loop to get the best value for each ID_data by comparing AIC
final_start_value <- data.frame(ID=NULL,AIC=NULL, r_max=NULL,N_0=NULL,K=NULL)
for (i in 1:length(unique(Data$ID))){
  # subset Data by ID
  id <- unique(Data$ID)[i]
  data <- subset(Data, Data$ID == id)
  
  # get prelimilary r_max
  if (length(data$ID)<8){
    lm_growth <- lm(PopBio ~ Time, data)
  }else{
    rag <- range(data$Time)[2]-range(data$Time)[1]
    lm_growth <- lm(PopBio ~ Time, data= data[data$Time > (min(data$Time) + 1/5*(rag)) & data$Time < (min(data$Time) + 1/2*(rag)),])
  }
  pre_r <- as.numeric(coef(lm_growth)[2])

  # set sample time and range factor
  SampTimes <- 1000
  fact <- 1
  
  # sample
  SampMin <- runif(SampTimes,min(data$PopBio)-abs(min(data$PopBio))*fact,min(data$PopBio)+abs(min(data$PopBio))*fact)
  SampMax <- runif(SampTimes,max(data$PopBio)-abs(max(data$PopBio))*fact,max(data$PopBio)+abs(max(data$PopBio))*fact)
  Samp_r_max <- runif(SampTimes, pre_r - abs(pre_r)*fact, pre_r + abs(pre_r)*fact)
  

  result_ID <- data.frame(ID=NULL, AIC=NULL, N_0=NULL,r_max=NULL,K=NULL)
  for (j in 1:SampTimes){
    
    result <- GuessStart(data,t = Time, r_maxS = Samp_r_max[j], N_0S = SampMin[j], KS = SampMax[j])
    if (is.na(result)){
      df <- data.frame(ID=id ,AIC=NA,N_0=NA, r_max=NA,K=NA)
    }
    else{
      df <- data.frame(ID=id ,AIC=result[1], N_0=result[2],r_max=result[3],K=result[4])
    }
    
    result_ID <- rbind(result_ID, df)
  }
  
  start_value <- subset(result_ID, result_ID$AIC == min(na.omit(result_ID$AIC)))
  final_start_value <- rbind(final_start_value, start_value[1,])
}

# 4. save the starting value for each ID into csv
write.csv(final_start_value, "../data/logistic_Starting_Value.csv")
