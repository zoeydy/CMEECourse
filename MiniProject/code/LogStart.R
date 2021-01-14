
rm(list = ls())
graphics.off()


require(minpack.lm)


# 1. define model and starting_value_guess functions
model_logistic <- function(t, r_max, N_0, K){
  return(log(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1))))
}

GuessStart <- function(t, r_maxS, N_0S, KS, data){
  out <- tryCatch(
    epr <- {
      nlsLM(logN~model_logistic(t=Time, r_max, N_0, K), data,
            start = list(r_max = r_maxS, N_0 = N_0S, K = KS))
    },
    # warning = function(w){
    #   #print(w)
    #   return(NA)
    # },
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
    # calculate the plot datapoints
    time2plot <- seq(min(data$Time), max(data$Time), length=1000)
    predi_log <- predict(epr, newdata = list(Time = time2plot), interval = "confidence")
    return(c(AIC, rsq, r_maxS, N_0S, KS, predi_log))
  }
  #print(out)
  return(out)
}


# 2. read the data
Data <- read.csv('../data/pop.csv')
Data <- subset(Data, Data$PopBio > 0)
Data$logN <- log(Data$PopBio)
Data <- subset(Data[!is.na(Data$logN),])
Data <- Data[order(Data[,2], Data[,4]),]

# 3. for loop for each id
start_value_df <- data.frame()
plot_df <- data.frame()
for (i in 1:length(unique(Data$ID))){
  
  # subset Data by ID
  id <- unique(Data$ID)[i]
  data <- subset(Data, Data$ID == id)
  
  # get starting values
  N0start <- min(data$PopBio)
  Kstart <- max(data$PopBio)
  # set the index (for calculating r_max)
  data$index <- seq(1:nrow(data))
  interval <- max(data$index) - min(data$index)
  index_low <- min(data$index) + 0.2*interval
  index_high <- min(data$index) + 0.8*interval
  # r_max
  if (length(data$Time) <= 5) {
    lm_fit <- lm(logN~Time, data)
  }else{
    lm_fit <- lm(logN~Time, data[data$index > index_low & data$index < index_high,])
  }
  rStart <- coef(lm_fit)[2]
  
  # sample
  SampTimes <- 1000
  fact <- 1
  Samp_r <- runif(SampTimes, 0, rStart + abs(rStart)*1)
  SampMin <- runif(SampTimes,N0start-abs(N0start)*0.2,N0start+abs(N0start)*0.2)
  SampMax <- runif(SampTimes,Kstart-abs(Kstart)*0.2,Kstart+abs(Kstart)*0.2)

  start_id_list <- list()
  plot_id_list <- list()
  for (j in 1:SampTimes){
    result <- GuessStart(data,t = Time, r_maxS = Samp_r[j], N_0S = SampMin[j], KS = SampMax[j])
    start_id_list[[j]] <- result[1:5]
    plot_id_list[[j]] <- result[6:1005]
  }
  
  # write the start_id_list into data frame
  n.obs <- sapply(start_id_list, length)
  seq.max <- seq_len(max(n.obs))
  start_id_mat <- t(sapply(start_id_list, "[", i = seq.max))
  start_id_df <- as.data.frame(start_id_mat)
  start_id_df$index <- seq(1:1000)
  colnames(start_id_df) <- c("AIC","RSq","r_max","N_0","K","index")
  index <- start_id_df$index[which.min(start_id_df$AIC)]
  
  # write the plot_id_list into data frame
  plot_id_df <- as.data.frame(plot_id_list[index])
  
  if (nrow(start_id_df[index,]) == 0) {
    start_id_df <- data.frame(ID=id,Model="logistic",AIC=NA,RSq=NA,r_max=NA,N_0=NA,K=NA,index=NA)
    start_value_df <- rbind(start_value_df, start_id_df)
    
    plot_id_df <- data.frame(pred_log=NA,ID=id,model="logistic")
    plot_df <- rbind(plot_df, plot_id_df)
  }else{
    start_id_df <- data.frame(ID=id,model="logistic",start_id_df[index,])
    colnames(start_id_df) <- c("ID","Model","AIC","RSq","r_max","N_0","K","index")
    start_value_df <- rbind(start_value_df, start_id_df)
    
    plot_id_df$ID <- id
    plot_id_df$model <- "logistic"
    colnames(plot_id_df) <- c("pred_log", "ID", "model")
    plot_df <- rbind(plot_df, plot_id_df)
  }
}

# 4. save the starting value for each ID into csv
write.csv(start_value_df, "../results/logistic_Starting_Value.csv")
write.csv(plot_df, "../results/logistic_plot_points.csv")
